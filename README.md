[![Gem Version](https://badge.fury.io/rb/Algorithmically.svg)](https://badge.fury.io/rb/Algorithmically)
[![Build Status](https://travis-ci.org/popac/Algorithmically.svg?branch=master)](https://travis-ci.org/popac/Algorithmically)
[![wercker status](https://app.wercker.com/status/e456d9eec98db3773239631ea504aa2d/s/master "wercker status")](https://app.wercker.com/project/byKey/e456d9eec98db3773239631ea504aa2d)
[![CodeFactor](https://www.codefactor.io/repository/github/popac/algorithmically/badge)](https://www.codefactor.io/repository/github/popac/algorithmically)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/f41c60b391b6429388da223039873768)](https://www.codacy.com/manual/webguruserbia/Algorithmically?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=popac/Algorithmically&amp;utm_campaign=Badge_Grade)
[![codebeat badge](https://codebeat.co/badges/bba4673e-a293-4107-847c-fdf6dcbf655b)](https://codebeat.co/projects/github-com-popicic-algorithmically-master)
[![BCH compliance](https://bettercodehub.com/edge/badge/popicic/Algorithmically?branch=master)](https://bettercodehub.com/)

# Algorithmically

## Nature Inspired Programming Recipes

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'Algorithmically'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install Algorithmically
    
## Usage

### Evolutionary Algorithms

#### Genetic

    Algorithmically::Evolutionary::Genetic.new(100, 64, 100, 0.98)

### Neural Algorithms

#### Perceptron

    Algorithmically::Neural::Perceptron.new([[0,0,0], [0,1,1], [1,0,1], [1,1,1]], 2, 20, 0.1)

### Stochastic Algorithms
    
#### Random Search
    
    Algorithmically::Stochastic::RandomSearch.new do |config|
      config.problem_size = 10
      config.maximum_iterations = 10
      config.negative_space = 2
      config.positive_space = 2
    end

    Algorithmically::Stochastic::RandomSearch.best_solution
    
#### Adaptive Random Search

    Algorithmically::Stochastic::AdaptiveRandomSearch.new(1000, 2, 0.05, 1.3, 3.0, 10, 30)
    
#### Hill Climbing

    Algorithmically::Stochastic::HillClimbing.new(2, 1000)
    
#### Guided Local Search

    Algorithmically::Stochastic::GuidedLocalSearch.new(150, [[565,575],[25,185],[345,750],[945,685]], 20, 0.3)
    
    b52 = [[595,360],[1340,725],[1740,245]]
    max_iterations = 150
    max_no_improv = 20
    alpha = 0.3
    local_search_optima = 12000.0
    lambda = alpha * (local_search_optima/b52.size.to_f)

#### Iterated Local Search

    Algorithmically::Stochastic::Iterated_Local_Search.search(max_iterations, b52, max_no_improv, lambda)

### Swarm Algorithms

#### Particle Swarm

    Algorithmically::Swarm::ParticleSwarm.new(2, 100, 1000, 1000, 50, 100.0, 2.0, 2.0)
