module StrongRoutes
  class Config
    attr_accessor :enabled,
      :insert_after,
      :insert_before,
      :message

    attr_reader :allowed_routes, :route_matchers

    def initialize
      @allowed_routes = Set.new
      @enabled = true
      @message = "Resource Not Found"
      @route_matchers = []
    end

    def allowed_routes=(value)
      raise TypeError, "allowed routes must be an Enumerable" unless value.is_a?(Enumerable)
      @allowed_routes = value.to_set
      @route_matchers = allowed_routes.map { |route| StrongRoutes::RouteMatcher.new(route) }
    end

    def enabled?
      !!enabled
    end

    def insert_after?
      !!insert_after
    end

    def insert_before?
      !!insert_before
    end
  end
end
