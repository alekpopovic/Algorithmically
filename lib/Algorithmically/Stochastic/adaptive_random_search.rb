module Stochastic

  class AdaptiveRandomSearch

    def objective_function(vector)
      vector.inject(0) { |sum, x| sum + (x ** 2.0) }
    end

    def rand_in_bounds(min, max)
      min + ((max-min))
    end

    def random_vector(minmax)
      Array.new(minmax.size) do |i|
        rand_in_bounds(minmax[i][0], minmax[i][1])
      end
    end

    def take_step(minmax, current, step_size)
      position = Array.new(current.size)
      position.size.times do |i|
        min = [minmax[i][0], current[i]-step_size].max
        max = [minmax[i][1], current[i]+step_size].min
        position[i] = rand_in_bounds(min, max)
      end
      position
    end

    def large_step_size(iter, step_size, s_factor, l_factor, iter_mult)
      step_size * l_factor if iter > 0 and iter.modulo(iter_mult) == 0
      step_size * s_factor
    end

  end

end