require 'rubygems'
require 'bundler'

::Bundler.require(:default, :development, :test)

require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/pride'

include ::Rack::Test::Methods

class MiniTest::Spec < MiniTest::Unit::TestCase
  class << self
    alias_method :setup, :before
    alias_method :teardown, :after
    alias_method :should, :it
    alias_method :context, :describe
  end
end
