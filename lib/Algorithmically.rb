# frozen_string_literal: true

require 'Algorithmically/version'

require 'Algorithmically/Stochastic/random_search'
require 'Algorithmically/Stochastic/adaptive_random_search'
require 'Algorithmically/Stochastic/hill_climbing'
require 'Algorithmically/Stochastic/iterated_local_search'
require 'Algorithmically/Stochastic/guided_local_search'
require 'Algorithmically/Stochastic/variable_neighborhood_search'
require 'Algorithmically/Stochastic/greedy_randomized_adaptive _search'
require 'Algorithmically/Stochastic/scatter_search'
require 'Algorithmically/Stochastic/reactive_rabu_search'

require 'Algorithmically/Evolutionary/genetic'
require 'Algorithmically/Neural/perceptron'

require 'Algorithmically/Swarm/particle_swarm'

module Algorithmically
  include Evolutionary
  include Neural
  include Stochastic
  include Swarm
end
