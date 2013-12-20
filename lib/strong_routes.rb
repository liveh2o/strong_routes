require "strong_routes/version"
require 'strong_routes/config'

module StrongRoutes
  def self.config
    @config ||= Config.new
  end

  # Initialize the config
  config
end
