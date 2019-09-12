[![Gem Version](https://badge.fury.io/rb/Algorithmically.svg)](https://badge.fury.io/rb/Algorithmically)
[![Build Status](https://travis-ci.org/popac/Algorithmically.svg?branch=master)](https://travis-ci.org/popac/Algorithmically)
[![wercker status](https://app.wercker.com/status/e456d9eec98db3773239631ea504aa2d/s/master "wercker status")](https://app.wercker.com/project/byKey/e456d9eec98db3773239631ea504aa2d)
[![CodeFactor](https://www.codefactor.io/repository/github/popac/algorithmically/badge)](https://www.codefactor.io/repository/github/popac/algorithmically)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/f41c60b391b6429388da223039873768)](https://www.codacy.com/manual/webguruserbia/Algorithmically?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=popac/Algorithmically&amp;utm_campaign=Badge_Grade)
[![codebeat badge](https://codebeat.co/badges/48da97f1-7562-4d44-8af6-0355f869d891)](https://codebeat.co/projects/github-com-popac-algorithmically-master)
[![BCH compliance](https://bettercodehub.com/edge/badge/popac/Algorithmically?branch=master)](https://bettercodehub.com/)

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

### Stochastic Algorithms
    
#### Random Search
    
    Algorithmically::Stochastic::RandomSearch.new do |config|
      config.problem_size = 10
      config.maximum_iterations = 10
      config.negative_space = 2
      config.positive_space = 2
    end

    Algorithmically::Stochastic::RandomSearch.best_solution

