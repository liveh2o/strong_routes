module StrongRoutes
  class Allow
    MESSAGE = "Resource Not Found".freeze

    def initialize(app, options = {})
      @app = app
      @options = ::StrongRoutes.config.merge(options)
    end

    def call(env)
      return @app.call(env) unless enabled?

      request = ::Rack::Request.new(env)

      if allowed?(request)
        @app.call(env)
      else
        [ 404, { "Content-Type" => "text/html", "Content-Length" => "18" }, [ MESSAGE ] ]
      end
    end

  private

    def allowed_routes
      @allowed_routes ||= begin
        routes = [ @options[:allowed_routes] ]
        routes.flatten!
        routes.compact!
        routes.uniq!
        routes
      end
    end

    def allowed?(request)
      route_matchers.any? { |route_matcher| route_matcher =~ request.path_info }
    end

    def enabled?
      @options[:enabled]
    end

    def route_matchers
      @route_matchers ||= allowed_routes.map { |allowed_route| ::StrongRoutes::RouteMatcher.new(allowed_route) }
    end
  end
end
