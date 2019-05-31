# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'Algorithmically/version'

Gem::Specification.new do |spec|
  spec.name = 'Algorithmically'
  spec.version = Algorithmically::VERSION
  spec.authors = ['popicic']
  spec.email = ['aleksandar.popovic.popac@gmail.com']

  spec.summary = 'Algorithmically'
  spec.description = 'Nature-Inspired Programming Recipes'
  spec.homepage = 'https://github.com/nedrogriz/Algorithmically'
  spec.license = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 1.17.1', '~> 2.0'
  spec.add_development_dependency 'pry', '~> 0.12.2'
  spec.add_development_dependency 'rake', '~> 12.3', '>= 12.3.1'
  spec.add_development_dependency 'rubocop', '~> 0.71.0'
  spec.add_development_dependency 'rspec', '~> 3.8'
end
