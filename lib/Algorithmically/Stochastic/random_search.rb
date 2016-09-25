module Stochastic

  class RandomSearch

    def initialize(size, max_iter)
      problem_size = size
      search_space = Array.new(problem_size) { |i| [-5, +5] }
      maximum_iterations = max_iter
      best_solution = self.search(search_space, maximum_iterations)
      puts "Done. Best Solution: c = #{best_solution[:cost]}, v = #{best_solution[:vector].inspect}"
    end

    def objective_function(vector)
      vector.inject(0) { |sum, x| sum + (x ** 2.0) }
    end

    def random_vector(minmax)
      Array.new(minmax.size) do |i|
        minmax[i][0] + ((minmax[i][1]) - minmax[i][0] * rand())
      end
    end

    def search(search_space, maximum_iterations)
      best_solution = nil
      maximum_iterations.times do |iterate|
        search_candidate = {}
        search_candidate[:vector] = random_vector(search_space)
        search_candidate[:cost] = objective_function(search_candidate[:vector])
        best_solution = search_candidate if best_solution.nil? or search_candidate[:cost] < best_solution[:cost]
        puts " > iteration = #{(iterate + 1)}, best = #{best_solution[:cost]}"
      end
      best_solution
    end

  end

end