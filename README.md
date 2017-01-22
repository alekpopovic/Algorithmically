# Algorithmically

Nature-Inspired Programming Recipes [![Gem Version](https://badge.fury.io/rb/Algorithmically.svg)](https://badge.fury.io/rb/Algorithmically)

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

    Algorithmically::Evolutionary::Genetic.new(100, 64, 100, 0.98)

### Neural Algorithms

    Algorithmically::Neural::Perceptron.new([[0,0,0], [0,1,1], [1,0,1], [1,1,1]], 2, 20, 0.1)

### Stochastic Algorithms
    
    Algorithmically::Neural::RandomSearch.new(2, 50)

    Algorithmically::Neural::AdaptiveRandomSearch.new(1000, 2, 0.05, 1.3, 3.0, 10, 30)
    
    Algorithmically::Neural::HillClimbing.new(2, 1000)
    
    Algorithmically::Neural::GuidedLocalSearch.new(150, [[565,575],[25,185],[345,750],[945,685]], 20, 0.3)

### Swarm Algorithms

    Algorithmically::Swarm::ParticleSwarm.new(2, 100, 1000, 1000, 50, 100.0, 2.0, 2.0)


