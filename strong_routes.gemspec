# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'strong_routes/version'

Gem::Specification.new do |spec|
  spec.name          = "strong_routes"
  spec.version       = StrongRoutes::VERSION
  spec.authors       = ["Adam Hutchison"]
  spec.email         = ["liveh2o@gmail.com"]
  spec.summary       = %q{Middleware to reject/allow requests before allocating a database connection}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rack"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
