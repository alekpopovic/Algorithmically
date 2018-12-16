module Algorithmically
  module Stochastic
    module Objectable
      def self.perform(vector)
        vector.inject(0) { |sum, x| sum + (x ** 2.0) }
      end
    end
  end
end
