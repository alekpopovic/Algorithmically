# frozen_string_literal: true

module Algorithmically
  module Stochastic
    class TabuSearch
      def euc_2d(c1, c2)
        Math.sqrt((c1[0] - c2[0])**2.0 + (c1[1] - c2[1])**2.0).round
      end

      def cost(perm, cities)
        distance = 0
        perm.each_with_index do |c1, i|
          c2 = i == perm.size - 1 ? perm[0] : perm[i + 1]
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

      def stochastic_two_opt(parent)
        perm = Array.new(parent)
        c1 = rand(perm.size)
        c2 = rand(perm.size)
        exclude = [c1]
        exclude << (c1 == 0 ? perm.size - 1 : c1 - 1)
        exclude << (c1 == perm.size - 1 ? 0 : c1 + 1)
        c2 = rand(perm.size) while exclude.include?(c2)
        c1, c2 = c2, c1 if c2 < c1
        perm[c1...c2] = perm[c1...c2].reverse
        [perm, [[parent[c1 - 1], parent[c1]], [parent[c2 - 1], parent[c2]]]]
      end

      def is_tabu?(permutation, tabu_list)
        permutation.each_with_index do |c1, i|
          c2 = i == permutation.size - 1 ? permutation[0] : permutation[i + 1]
          tabu_list.each do |forbidden_edge|
            return true if forbidden_edge == [c1, c2]
          end
        end
        false
      end

      def generate_candidate(best, tabu_list, cities)
        perm = nil
        edges = nil
        begin
          perm, edges = stochastic_two_opt(best[:vector])
        end while is_tabu?(perm, tabu_list)
        candidate = { vector: perm }
        candidate[:cost] = cost(candidate[:vector], cities)
        [candidate, edges]
      end

      def search(cities, tabu_list_size, candidate_list_size, max_iter)
        current = { vector: random_permutation(cities) }
        current[:cost] = cost(current[:vector], cities)
        best = current
        tabu_list = Array.new(tabu_list_size)
        max_iter.times do |iter|
          candidates = Array.new(candidate_list_size) do |_i|
            generate_candidate(current, tabu_list, cities)
          end
          candidates.sort! { |x, y| x.first[:cost] <=> y.first[:cost] }
          best_candidate = candidates.first[0]
          best_candidate_edges = candidates.first[1]
          if best_candidate[:cost] < current[:cost]
            current = best_candidate
            best = best_candidate if best_candidate[:cost] < best[:cost]
            best_candidate_edges.each { |edge| tabu_list.push(edge) }
            tabu_list.pop while tabu_list.size > tabu_list_size
          end
          puts " > iteration #{(iter + 1)}, best=#{best[:cost]}"
        end
        best
      end
    end
  end
end
