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

    @count = 0

    shape :start do    
      block size: 1.0
    end

    shape :block do
      square
      split do
        @count += 1
        if(@count < 40)
          block size: 0.85, rotation: 3, brightness: 0.9
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
    start_x: width/2,
    start_y: height/2, 
    size: height/2,
    color: [0.0, 0.0, 1.0, 1.0]
end
