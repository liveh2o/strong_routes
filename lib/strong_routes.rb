require "rack/request"

require "strong_routes/allow"
require "strong_routes/config"
require "strong_routes/route_matcher"
require "strong_routes/version"

module StrongRoutes
  def self.config
    @config ||= Config.new
  end

  # Initialize the config
  config
end

require "strong_routes/rails/railtie" if defined?(Rails)
