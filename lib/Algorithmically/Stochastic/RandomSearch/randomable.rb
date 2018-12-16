module Algorithmically
  module Stochastic
    module Randomable
      def self.perform(minmax)
        Array.new(minmax.size) do |i|
          minmax[i][0] + ((minmax[i][1]) - minmax[i][0] * rand)
        end
      end
    end
  end
end
