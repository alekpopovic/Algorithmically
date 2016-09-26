require 'Algorithmically/version'
require 'Algorithmically/Evolutionary/genetic'
require 'Algorithmically/Neural/perceptron'
require 'Algorithmically/Stochastic/random_search'
require 'Algorithmically/Stochastic/hill_climbing'
require 'Algorithmically/Stochastic/guided_local_search'
require 'Algorithmically/Swarm/particle_swarm'


module Algorithmically
  include Evolutionary
  include Neural
  include Stochastic
  include Swarm
end
