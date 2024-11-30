# frozen_string_literal: true

# Start SimpleCov
require "simplecov"
SimpleCov.start do
  add_filter "/test"
end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "strong_routes"

require "minitest/autorun"
require "minitest/pride"
require "minitest/spec"
require "rack/test"

class Minitest::Spec
  class << self
    alias_method :setup, :before
    alias_method :teardown, :after
    alias_method :should, :it
    alias_method :context, :describe
  end
end
