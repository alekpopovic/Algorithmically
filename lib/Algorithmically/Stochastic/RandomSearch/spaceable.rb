module Algorithmically
  module Stochastic
    module Spaceable
      def self.perform(size, negative, positive)
        Array.new(size) { |i| [- negative, + positive] }
      end
    end
  end
end
