# frozen_string_literal: true

module Algorithmically
  module Stochastic
    class AdaptiveRandomSearch
      def initialize(max_iter, bounds, init_factor, s_factor, l_factor, iter_mult, max_no_impr)
        problem_size = bounds
        @bounds1 = Array.new(problem_size) { |_i| [-5, +5] }
        @max_iter = max_iter
        @init_factor = init_factor
        @s_factor = s_factor
        @l_factor = l_factor
        @iter_mult = iter_mult
        @max_no_impr = max_no_impr
        @best = search(@max_iter, @bounds1, @init_factor, @s_factor, @l_factor, @iter_mult, @max_no_impr)
        puts "Done. Best Solution: c=#{@best[:cost]}, v=#{@best[:vector].inspect}"
      end

      def objective_function(vector)
        vector.inject(0) { |sum, x| sum + (x**2.0) }
      end

      def rand_in_bounds(min, max)
        min + ((max - min) * rand)
      end

      def random_vector(minmax)
        Array.new(minmax.size) do |i|
          rand_in_bounds(minmax[i][0], minmax[i][1])
        end
      end

      def take_step(minmax, current, step_size)
        position = Array.new(current.size)
        position.size.times do |i|
          min = [minmax[i][0], current[i] - step_size].max
          max = [minmax[i][1], current[i] + step_size].min
          position[i] = rand_in_bounds(min, max)
        end
        position
      end

      def large_step_size(iter, step_size, s_factor, l_factor, iter_mult)
        step_size * l_factor if (iter > 0) && (iter.modulo(iter_mult) == 0)
        step_size * s_factor
      end

      def take_steps(bounds, current, step_size, big_stepsize)
        step = {}
        big_step = {}
        step[:vector] = take_step(bounds, current[:vector], step_size)
        step[:cost] = objective_function(step[:vector])
        big_step[:vector] = take_step(bounds, current[:vector], big_stepsize)
        big_step[:cost] = objective_function(big_step[:vector])
        [step, big_step]
      end

      def search(max_iter, bounds, init_factor, s_factor, l_factor, iter_mult, max_no_impr)
        step_size = (bounds[0][1] - bounds[0][0]) * init_factor
        current = {}
        count = 0
        current[:vector] = random_vector(bounds)
        current[:cost] = objective_function(current[:vector])
        max_iter.times do |iter|
          big_stepsize = large_step_size(iter, step_size, s_factor, l_factor, iter_mult)
          step, big_step = take_steps(bounds, current, step_size, big_stepsize)
          if (step[:cost] <= current[:cost]) || (big_step[:cost] <= current[:cost])
            if big_step[:cost] <= step[:cost]
              step_size = big_stepsize
              current = big_step
            else
              current = step
            end
            count = 0
          else
            count += 1
            if count >= max_no_impr
              count = 0
              step_size = (step_size / s_factor)
            end
          end
          puts " > iteration #{(iter + 1)}, best=#{current[:cost]}"
        end
        current
      end
    end
  end
end
