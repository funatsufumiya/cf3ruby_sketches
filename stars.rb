require 'cf3'

def init_shape

  @my_shape = ContextFree.define do
  
    class << self
    include Math
      define_method(:custom_shape) do |some_options|      
        size, options = *self.get_shape_values(some_options)
        rot = options[:rotation]
        # rotate(rot) if rot                                    
        # @app.triangle(0, 0, size, 0, size * cos(PI/5), size * sin(PI/5))
        # rotate(-rot) if rot
      end
    end

    shape :start do
      split do
        (0..10).each do |i|
          (-5..5).each do |px|
            (-5..5).each do |py|
              dx = rand(-0.7...0.7)
              dy = rand(-0.7...0.7)
              hue_d = rand(-10...10)
              bri_d = rand(-0.5...0.0)
              sat_d = rand(-0.5...0.0)
              # a = rand(0.5...1.0)
              r = rand(-60...60)
              star x: px + dx, y: py + dy, my_rot: r, my_size: 0.5, color: [60 + hue_d, 1.0 + sat_d, 1.0 + bri_d, 1.0]
              rewind
            end
          end
        end
      end
    end

    shape :star do |v|
      my_size = if v[:my_size] then v[:my_size] else 0.5 end
      my_rot = if v[:my_rot] then v[:my_rot] else 0 end

      # split do
        star_shadow x: -0.02, y: -0.02, my_size: my_size, my_rot: my_rot
        star_body my_size: my_size, my_rot: my_rot
      # end
    end

    shape :star_body do |v|
      my_size = v[:my_size]
      my_rot = v[:my_rot]
      split do
        triangle rotation: my_rot, size: my_size
        triangle rotation: my_rot + 180, size: my_size
      end
    end

    shape :star_shadow do |v|
      my_size = v[:my_size]
      my_rot = v[:my_rot]
      split do
        triangle rotation: my_rot, size: my_size, color: [0, 0.0, 0.0, 0.3]
        triangle rotation: my_rot + 180, size: my_size, color: [0, 0.0, 0.0, 0.3]
      end
    end

  end
end

def settings
  size 800, 800
end

def setup
  background 20, 1
  init_shape
  draw_it
end

def draw_it
  @my_shape.render :start,
    start_x: width/2,
    start_y: height/2, 
    size: height/10
end
