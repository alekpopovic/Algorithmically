module Algorithmically
  module Stochastic

    class HillClimbing

      def initialize(max_iterations, num_bits)
        best = search(max_iterations, num_bits)
        puts "Done. Best Solution: c=#{best[:cost]}, v=#{best[:vector].join}"
      end

      def onemax(vector)
        vector.inject(0.0) { |sum, v| sum + ((v=="1") ? 1 : 0) }
      end

      def random_bitstring(num_bits)
        Array.new(num_bits) { |i| (rand<0.5) ? "1" : "0" }
      end

      def random_neighbor(bitstring)
        mutant = Array.new(bitstring)
        pos = rand(bitstring.size)
        mutant[pos] = (mutant[pos]=='1') ? '0' : '1'
        mutant
      end

      def search(max_iterations, num_bits)
        candidate = {}
        candidate[:vector] = random_bitstring(num_bits)
        candidate[:cost] = onemax(candidate[:vector])
        max_iterations.times do |iter|
          neighbor = {}
          neighbor[:vector] = random_neighbor(candidate[:vector])
          neighbor[:cost] = onemax(neighbor[:vector])
          candidate = neighbor if neighbor[:cost] >= candidate[:cost]
          puts " > iteration #{(iter+1)}, best=#{candidate[:cost]}"
          break if candidate[:cost] == num_bits
        end
        candidate
      end

    end

  end
end