module Algorithmically
  module Stochastic

    class GuidedLocalSearch

      def initialize(max_iterations, berlin52, max_no_improv, lambda)
        @berlin52 = berlin52
        @max_iterations = max_iterations
        @max_no_improv = max_no_improv
        alpha = 0.3
        local_search_optima = 12000.0
        lambda = alpha * (local_search_optima/berlin52.size.to_f)
        @lambda = lambda
        best = search(@max_iterations, @berlin52, @max_no_improv, lambda)
        puts "Done. Best Solution: c=#{best[:cost]}, v=#{best[:vector].inspect}"
      end

      def euc_2d(c1, c2)
        Math.sqrt((c1[0] - c2[0])**2.0 + (c1[1] - c2[1])**2.0).round
      end

      def random_permutation(cities)
        perm = Array.new(cities.size) { |i| i }
        perm.each_index do |i|
          r = rand(perm.size-i) + i
          perm[r], perm[i] = perm[i], perm[r]
        end
        perm
      end

      def stochastic_two_opt(permutation)
        perm = Array.new(permutation)
        c1, c2 = rand(perm.size), rand(perm.size)
        exclude = [c1]
        exclude << ((c1==0) ? perm.size-1 : c1-1)
        exclude << ((c1==perm.size-1) ? 0 : c1+1)
        c2 = rand(perm.size) while exclude.include?(c2)
        c1, c2 = c2, c1 if c2 < c1
        perm[c1...c2] = perm[c1...c2].reverse
        perm
      end

      def augmented_cost(permutation, penalties, cities, lambda)
        distance, augmented = 0, 0
        permutation.each_with_index do |c1, i|
          c2 = (i==permutation.size-1) ? permutation[0] : permutation[i+1]
          c1, c2 = c2, c1 if c2 < c1
          d = euc_2d(cities[c1], cities[c2])
          distance += d
          augmented += d + (lambda * (penalties[c1][c2]))
        end
        [distance, augmented]
      end

      def cost(cand, penalties, cities, lambda)
        cost, acost = augmented_cost(cand[:vector], penalties, cities, lambda)
        cand[:cost], cand[:aug_cost] = cost, acost
      end

      def local_search(current, cities, penalties, max_no_improv, lambda)
        cost(current, penalties, cities, lambda)
        count = 0
        begin
          candidate = {:vector => stochastic_two_opt(current[:vector])}
          cost(candidate, penalties, cities, lambda)
          count = (candidate[:aug_cost] < current[:aug_cost]) ? 0 : count+1
          current = candidate if candidate[:aug_cost] < current[:aug_cost]
        end until count >= max_no_improv
        current
      end

      def calculate_feature_utilities(penal, cities, permutation)
        utilities = Array.new(permutation.size, 0)
        permutation.each_with_index do |c1, i|
          c2 = (i==permutation.size-1) ? permutation[0] : permutation[i+1]
          c1, c2 = c2, c1 if c2 < c1
          utilities[i] = euc_2d(cities[c1], cities[c2]) / (1.0 + penal[c1][c2])
        end
        utilities
      end

      def update_penalties!(penalties, cities, permutation, utilities)
        max = utilities.max()
        permutation.each_with_index do |c1, i|
          c2 = (i==permutation.size-1) ? permutation[0] : permutation[i+1]
          c1, c2 = c2, c1 if c2 < c1
          penalties[c1][c2] += 1 if utilities[i] == max
        end
        penalties
      end

      def search(max_iterations, cities, max_no_improv, lambda)
        current = {:vector => random_permutation(cities)}
        best = nil
        penalties = Array.new(cities.size) { Array.new(cities.size, 0) }
        max_iterations.times do |iter|
          current=local_search(current, cities, penalties, max_no_improv, lambda)
          utilities=calculate_feature_utilities(penalties, cities, current[:vector])
          update_penalties!(penalties, cities, current[:vector], utilities)
          best = current if best.nil? or current[:cost] < best[:cost]
          puts " > iter=#{(iter+1)}, best=#{best[:cost]}, aug=#{best[:aug_cost]}"
        end
        best
      end

    end

  end
end