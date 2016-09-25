# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'Algorithmically/version'

Gem::Specification.new do |spec|
  spec.name = 'Algorithmically'
  spec.version = Algorithmically::VERSION
  spec.authors = ['popac']
  spec.email = ['web.guru.serbia@gmail.com']

  spec.summary = %q{Algorithmically}
  spec.description = %q{Nature-Inspired Programming Recipes}
  spec.homepage = 'https://github.com/popac/Algorithmically'
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

  spec.add_development_dependency 'bundler', '~> 1.13', '>= 1.13.1'
  spec.add_development_dependency 'rake', '~> 11.3'
  spec.add_development_dependency 'pry', '~> 0.10.4'
end