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
        (0..80).each do |i|
          tail rd: 10 - i*0.25, rotation: -160 + i*5, size: 0.1, color: [50 + i*5, 0.01, 1.0, 0.008]
          rewind
        end
      end
    end

    shape :tail do |v|
      c = if v[:count] then v[:count] else 0 end
      rd = if v[:rd] then v[:rd] else 6 end
      # p count
      square
      split do
        if(c < 10)
          tail count: c+1, rd: rd, size: 0.98, x: 0.2, y: 0.2, rotation: -rd, brightness: 0.99, saturation: 1.2, alpha: 1.4
        elsif(c < 40)
          tail count: c+1, rd: rd, size: 0.98, x: 0.2, y: 0.2, rotation: rd, brightness: 0.99, saturation: 1.2, alpha: 1.0
        elsif(c < 80)
          tail count: c+1, rd: rd, size: 0.98, x: 0.2, y: 0.2, rotation: -rd * 0.75, brightness: 0.99, saturation: 1.2, alpha: 0.99, hue: 1.01
        elsif(c < 120)
          tail count: c+1, rd: rd, size: 0.98, x: 0.2, y: 0.2, rotation: rd * 0.75, brightness: 0.99, saturation: 1.2, alpha: 0.99
        else
          # completed
        end
      end
    end

  end
end

def settings
  size 800, 800
end

def setup
  background 0, 1
  init_shape
  draw_it
end

def draw_it
  @my_shape.render :start,
    start_x: 0,
    start_y: 0, 
    size: height,
    color: [0.001, 0.001, 1.0, 0.3]
end
