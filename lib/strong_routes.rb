require "rack/response"

require "strong_routes/allow"
require "strong_routes/config"
require "strong_routes/route_matcher"
require "strong_routes/version"

module StrongRoutes
  def self.allowed?(route)
    config.route_matchers.any? { |route_matcher| route_matcher =~ route }
  end

  def self.config
    @config ||= Config.new
  end

  def self.response
    Rack::Response[config.status, config.headers, config.content]
  end

  # Initialize the config
  config
end

require "strong_routes/rails/railtie" if defined?(Rails)
