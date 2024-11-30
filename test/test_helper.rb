# Start SimpleCov
require "simplecov"
SimpleCov.start do
  add_filter "/test"
end

# Load gems with Bundler
require "bundler"
Bundler.require(:default, :development, :test)

require "minitest/autorun"
require "minitest/spec"
require "minitest/pride"

class Minitest::Spec
  class << self
    alias_method :setup, :before
    alias_method :teardown, :after
    alias_method :should, :it
    alias_method :context, :describe
  end
end
