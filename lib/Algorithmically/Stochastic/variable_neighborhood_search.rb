# frozen_string_literal: true

module Algorithmically
  module Stochastic
    # ##################################################################################################################
    #
    # Algorithm Pseudocode
    #
    # ##################################################################################################################
    # ##################################################################################################################
    # ##################################################################################################################
    #
    #  Input: Neighborhoods
    #  Output: S best
    #  Sbest ← RandomSolution();
    #  while ¬ StopCondition() do
    #    foreach N eighborhood i ∈ Neighborhoods do
    #      N eighborhood curr ← CalculateNeighborhood(S best ,
    #      N eighborhood i );
    #      S candidate ←
    #      RandomSolutionInNeighborhood(N eighborhood curr );
    #      S candidate ← LocalSearch(S candidate );
    #      if Cost(S candidate ) < Cost(S best ) then
    #        S best ← S candidate ;
    #        Break;
    #      end
    #    end
    #  end
    # 13 return S best ;
    #
    ####################################################################################################################
    ####################################################################################################################
    ####################################################################################################################
    class VariableNeighborhoodSearch
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

      def stochastic_two_opt!(perm)
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

      def local_search(best, cities, max_no_improv, neighborhood)
        count = 0
        begin
          candidate = {}
          candidate[:vector] = Array.new(best[:vector])
          neighborhood.times { stochastic_two_opt!(candidate[:vector]) }
          candidate[:cost] = cost(candidate[:vector], cities)
          if candidate[:cost] < best[:cost]
            count = 0
            best = candidate
          else
            count += 1
          end
        end until count >= max_no_improv
        best
      end

      def search(cities, neighborhoods, max_no_improv, max_no_improv_ls)
        best = {}
        best[:vector] = random_permutation(cities)
        best[:cost] = cost(best[:vector], cities)
        iter = 0
        count = 0
        begin
          neighborhoods.each do |neigh|
            candidate = {}
            candidate[:vector] = Array.new(best[:vector])
            neigh.times { stochastic_two_opt!(candidate[:vector]) }
            candidate[:cost] = cost(candidate[:vector], cities)
            candidate = local_search(candidate, cities, max_no_improv_ls, neigh)
            puts " > iteration #{(iter + 1)}, neigh=#{neigh}, best=#{best[:cost]}"
            iter += 1
            if candidate[:cost] < best[:cost]
              best = candidate
              count = 0
              puts 'New best, restarting neighborhood search.'
              65
              break
            else
              count += 1
            end
          end
        end until count >= max_no_improv
        best
      end
    end
  end
end
