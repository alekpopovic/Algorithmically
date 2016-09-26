require 'Algorithmically/version'
require 'Algorithmically/Neural/perceptron'
require 'Algorithmically/Stochastic/random_search'
require 'Algorithmically/Stochastic/hill_climbing'
require 'Algorithmically/Stochastic/guided_local_search'


module Algorithmically
  include Neural
  include Stochastic
end
