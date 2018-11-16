# frozen_string_literal: true

module Algorithmically
  module Stochastic
    class Iterated_Local_Search
      def euc_2d(c1, c2)
        Math.sqrt((c1[0] - c2[0])**2.0 + (c1[1] - c2[1])**2.0).round
      end

      def cost(permutation, cities)
        distance = 0
        permutation.each_with_index do |c1, i|
          c2 = i == permutation.size - 1 ? permutation[0] : permutation[i + 1]
          distance += euc_2d(cities[c1], cities[c2])
        end
        distance
      end

      def random_permutation(cities)
        perm = Array.new(cities.size) { |i| i }
        perm.each_index do |i|
          r = rand(perm.size - i) + i
          perm[r], perm[i] = perm[i], perm[r]
        end
        perm
      end

      def stochastic_two_opt(permutation)
        perm = Array.new(permutation)
        c1 = rand(perm.size)
        c2 = rand(perm.size)
        exclude = [c1]
        exclude << (c1 == 0 ? perm.size - 1 : c1 - 1)
        exclude << (c1 == perm.size - 1 ? 0 : c1 + 1)
        c2 = rand(perm.size) while exclude.include?(c2)
        c1, c2 = c2, c1 if c2 < c1
        perm[c1...c2] = perm[c1...c2].reverse
        perm
      end

      def local_search(best, cities, max_no_improv)
        count = 0
        begin
          candidate = { vector: stochastic_two_opt(best[:vector]) }
          candidate[:cost] = cost(candidate[:vector], cities)
          count = candidate[:cost] < best[:cost] ? 0 : count + 1
          best = candidate if candidate[:cost] < best[:cost]
        end until count >= max_no_improv
        best
      end

      def double_bridge_move(perm)
        pos1 = 1 + rand(perm.size / 4)
        pos2 = pos1 + 1 + rand(perm.size / 4)
        pos3 = pos2 + 1 + rand(perm.size / 4)
        p1 = perm[0...pos1] + perm[pos3..perm.size]
        p2 = perm[pos2...pos3] + perm[pos1...pos2]
        p1 + p2
      end

      def perturbation(cities, best)
        candidate = {}
        candidate[:vector] = double_bridge_move(best[:vector])
        candidate[:cost] = cost(candidate[:vector], cities)
        candidate
      end

      def search(cities, max_iterations, max_no_improv)
        best = {}
        best[:vector] = random_permutation(cities)
        best[:cost] = cost(best[:vector], cities)
        best = local_search(best, cities, max_no_improv)
        max_iterations.times do |iter|
          candidate = perturbation(cities, best)
          candidate = local_search(candidate, cities, max_no_improv)
          best = candidate if candidate[:cost] < best[:cost]
          puts " > iteration #{(iter + 1)}, best=#{best[:cost]}"
        end
        best
      end
    end
  end
end
