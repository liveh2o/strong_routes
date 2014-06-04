require 'rubygems'

# Start SimpleCov
require 'simplecov'
SimpleCov.start do
  add_filter "/spec"
end

# Load gems with Bundler
require 'bundler'
::Bundler.require(:default, :development, :test)

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'

include ::Rack::Test::Methods

class MiniTest::Spec
  class << self
    alias_method :setup, :before
    alias_method :teardown, :after
    alias_method :should, :it
    alias_method :context, :describe
  end
end
