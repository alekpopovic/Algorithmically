# Algorithmically

Nature-Inspired Programming Recipes 

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

### Stochastic Algorithms
    
    Algorithmically::RandomSearch.new(2, 50)

    Algorithmically::AdaptiveRandomSearch.new(1000, 2, 0.05, 1.3, 3.0, 10, 30)
    
    Algorithmically::HillClimbing.new(2, 1000)
    
    Algorithmically::GuidedLocalSearch.new(150, [[565,575],[25,185],[345,750],[945,685]], 20, 0.3)


