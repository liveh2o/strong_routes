lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "strong_routes/version"

Gem::Specification.new do |spec|
  spec.name = "strong_routes"
  spec.version = StrongRoutes::VERSION
  spec.authors = ["Adam Hutchison"]
  spec.email = ["liveh2o@gmail.com"]
  spec.summary = "Middleware to reject/allow requests before allocating a database connection or any resources"
  spec.description = spec.summary
  spec.homepage = "https://github.com/liveh2o/strong_routes"
  spec.license = "MIT"

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rack"

  spec.add_development_dependency "actionpack", "< 5.0.0", ">= 3.2.0"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "standardrb"
end
