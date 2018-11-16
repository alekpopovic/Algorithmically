# frozen_string_literal: true

module Algorithmically
  module Stochastic
    class GreedyRandomizedAdaptiveSearch
      # ################################################################################################################
      #
      # Algorithm Pseudocode
      #
      # ################################################################################################################
      # ################################################################################################################
      # ################################################################################################################
      #
      # Input: α
      # Output: S best
      # S best ← ConstructRandomSolution();
      # while ¬ StopCondition() do
      #   S candidate ← GreedyRandomizedConstruction(α);
      #   S candidate ← LocalSearch(S candidate );
      #   if Cost(S candidate ) < Cost(S best ) then
      #     S best ← S candidate ;
      #   end
      # end
      # return S best ;
      #
      # ################################################################################################################
      # ################################################################################################################
      # ################################################################################################################
      def euc_2d(c1, c2)
        Math.sqrt((c1[0] - c2[0]) ** 2.0 + (c1[1] - c2[1]) ** 2.0).round
      end

      def cost(perm, cities)
        distance = 0
        perm.each_with_index do |c1, i|
          c2 = (i == perm.size - 1) ? perm[0] : perm[i + 1]
          distance += euc_2d(cities[c1], cities[c2])
        end
        return distance
      end

      def stochastic_two_opt(permutation)
        perm = Array.new(permutation)
        c1, c2 = rand(perm.size), rand(perm.size)
        exclude = [c1]
        exclude << ((c1 == 0) ? perm.size - 1 : c1 - 1)
        exclude << ((c1 == perm.size - 1) ? 0 : c1 + 1)
        c2 = rand(perm.size) while exclude.include?(c2)
        c1, c2 = c2, c1 if c2 < c1
        perm[c1...c2] = perm[c1...c2].reverse
        return perm
      end

      def local_search(best, cities, max_no_improv)
        count = 0
        begin
          candidate = {:vector => stochastic_two_opt(best[:vector])}
          candidate[:cost] = cost(candidate[:vector], cities)
          count = (candidate[:cost] < best[:cost]) ? 0 : count + 1
          best = candidate if candidate[:cost] < best[:cost]
        end until count >= max_no_improv
        return best
      end

      def construct_randomized_greedy_solution(cities, alpha)
        candidate = {}
        candidate[:vector] = [rand(cities.size)]
        allCities = Array.new(cities.size) {|i| i}
        while candidate[:vector].size < cities.size
          candidates = allCities - candidate[:vector]
          costs = Array.new(candidates.size) do |i|
            euc_2d(cities[candidate[:vector].last], cities[i])
          end
          rcl, max, min = [], costs.max, costs.min
          costs.each_with_index do |c, i|
            rcl << candidates[i] if c <= (min + alpha * (max - min))
          end
          candidate[:vector] << rcl[rand(rcl.size)]
        end
        candidate[:cost] = cost(candidate[:vector], cities)
        return candidate
      end

      def search(cities, max_iter, max_no_improv, alpha)
        best = nil
        max_iter.times do |iter|
          candidate = construct_randomized_greedy_solution(cities, alpha);
          candidate = local_search(candidate, cities, max_no_improv)
          best = candidate if best.nil ?  candidate[:cost] < best[:cost] : ''
          puts " > iteration #{(iter + 1)}, best=#{best[:cost]}"
        end
        return best
      end
    end
  end
end