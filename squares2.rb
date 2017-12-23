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

    @count_a = 0
    @count_b = 0

    shape :start do
      split do
        block_a size: 0.1, x: 0.4, y: 0.4, color: [50, 0.01, 1.0, 0.3]
        rewind
        block_b size: 0.1, x: -0.4, y: -0.4, color: [100, 0.01, 1.0, 0.3]
      end
    end

    shape :block_a do
      square if(@count_a > 0)
      split do
        @count_a += 1
        if(@count_a < 160)
          block_a size: 0.98, x: 0.2, rotation: 15, brightness: 0.95, saturation: 1.4, alpha: 0.99
        end
      end
    end

    shape :block_b do
      square if(@count_b > 0)
      split do
        @count_b += 1
        if(@count_b < 160)
          block_b size: 0.98, x: -0.2, rotation: 15, brightness: 0.95, saturation: 1.4, alpha: 0.99
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
    size: height,
    color: [0.001, 0.001, 1.0, 0.3]
end
