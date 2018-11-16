module Algorithmically
  module Stochastic
    class ReactiveTabuSearch
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

      def random_permutation(cities)
        perm = Array.new(cities.size) {|i| i}
        perm.each_index do |i|
          r = rand(perm.size - i) + i
          perm[r], perm[i] = perm[i], perm[r]
        end
        return perm
      end

      def stochastic_two_opt(parent)
        perm = Array.new(parent)
        c1, c2 = rand(perm.size), rand(perm.size)
        exclude = [c1]
        exclude << ((c1 == 0) ? perm.size - 1 : c1 - 1)
        exclude << ((c1 == perm.size - 1) ? 0 : c1 + 1)
        c2 = rand(perm.size) while exclude.include?(c2)
        c1, c2 = c2, c1 if c2 < c1
        perm[c1...c2] = perm[c1...c2].reverse
        return perm, [[parent[c1 - 1], parent[c1]], [parent[c2 - 1], parent[c2]]]
      end

      def is_tabu?(edge, tabu_list, iter, prohib_period)
        tabu_list.each do |entry|
          if entry[:edge] == edge
            return true if entry[:iter] >= iter - prohib_period
            return false
          end
        end
        return false
      end

      def make_tabu(tabu_list, edge, iter)
        tabu_list.each do |entry|
          if entry[:edge] == edge
            entry[:iter] = iter
            return entry
          end
        end
        entry = {:edge => edge, :iter => iter}
        tabu_list.push(entry)
        return entry
      end

      def to_edge_list(perm)
        list = []
        perm.each_with_index do |c1, i|
          c2 = (i == perm.size - 1) ? perm[0] : perm[i + 1]
          c1, c2 = c2, c1 if c1 > c2
          list << [c1, c2]
        end
        return list
      end

      def equivalent?(el1, el2)
        el1.each {|e| return false if !el2.include?(e)}
        return true
      end

      def generate_candidate(best, cities)
        candidate = {}
        candidate[:vector], edges = stochastic_two_opt(best[:vector])
        candidate[:cost] = cost(candidate[:vector], cities)
        return candidate, edges
      end

      def get_candidate_entry(visited_list, permutation)
        edgeList = to_edge_list(permutation)
        visited_list.each do |entry|
          return entry if equivalent?(edgeList, entry[:edgelist])
        end
        return nil
      end

      def store_permutation(visited_list, permutation, iteration)
        entry = {}
        entry[:edgelist] = to_edge_list(permutation)
        entry[:iter] = iteration
        entry[:visits] = 1
        visited_list.push(entry)
        return entry
      end

      def sort_neighborhood(candidates, tabu_list, prohib_period, iteration)
        tabu, admissable = [], []
        candidates.each do |a|
          if is_tabu?(a[1][0], tabu_list, iteration, prohib_period) or
              is_tabu?(a[1][1], tabu_list, iteration, prohib_period)
            tabu << a
          else
            admissable << a
          end
        end
        return [tabu, admissable]
      end

      def search(cities, max_cand, max_iter, increase, decrease)
        current = {:vector => random_permutation(cities)}
        current[:cost] = cost(current[:vector], cities)
        best = current
        tabu_list, prohib_period = [], 1
        visited_list, avg_size, last_change = [], 1, 0
        max_iter.times do |iter|
          candidate_entry = get_candidate_entry(visited_list, current[:vector])
          if !candidate_entry.nil? repetition_interval = iter - candidate_entry[:iter]
            candidate_entry[:iter] = iter
            candidate_entry[:visits] += 1
            if repetition_interval < 2 * (cities.size - 1)
              avg_size = 0.1 * (iter - candidate_entry[:iter]) + 0.9 * avg_size
              prohib_period = (prohib_period.to_f * increase)
              last_change = iter
            end
          else
            store_permutation(visited_list, current[:vector], iter)
          end
          if iter - last_change > avg_size
            prohib_period = [prohib_period * decrease, 1].max
            last_change = iter
          end
          candidates = Array.new(max_cand) do |i|
            generate_candidate(current, cities)
          end
          candidates.sort! {|x, y| x.first[:cost] <=> y.first[:cost]}
          tabu, admis = sort_neighborhood(candidates, tabu_list, prohib_period, iter)
          if admis.size < 2
            prohib_period = cities.size - 2
            last_change = iter
          end
          current, best_move_edges = (admis.empty?) ? tabu.first : admis.first
          if !tabu.empty?
            tf = tabu.first[0]
            if tf[:cost] < best[:cost] and tf[:cost] < current[:cost]
              current, best_move_edges = tabu.first
            end
          end
          best_move_edges.each {|edge| make_tabu(tabu_list, edge, iter)}
          best = candidates.first[0] if candidates.first[0][:cost] < best[:cost]
          puts " > it=#{iter}, tenure=#{prohib_period.round}, best=#{best[:cost]}"
        end
        return best
      end
    end
  end
end
