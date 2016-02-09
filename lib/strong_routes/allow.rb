module StrongRoutes
  class Allow
    def initialize(app, options = {})
      @app = app
      @options = options
    end

    def _call(env)
      return @app.call(env) unless enabled?

      request = ::Rack::Request.new(env)

      if allowed?(request)
        @app.call(env)
      else
        [ 404, { "Content-Type" => "text/html", "Content-Length" => config.message.length.to_s }, [ config.message ] ]
      end
    end

    # HACK: This makes this middleware threadsafe, but is not a very good pattern.
    # We should rewrite this to use a separate class with instance-level stuff.
    def call(env)
      dup._call(env)
    end

  private

    def allowed_routes
      @allowed_routes ||= begin
        routes = [ config.allowed_routes ]
        routes.flatten!
        routes.compact!
        routes.uniq!
        routes
      end
    end

    def allowed?(request)
      route_matchers.any? { |route_matcher| route_matcher =~ request.path_info }
    end

    def config
      @config ||= StrongRoutes.config.merge(@options)
    end

    def enabled?
      config.enabled?
    end

    def route_matchers
      @route_matchers ||= allowed_routes.map { |allowed_route| ::StrongRoutes::RouteMatcher.new(allowed_route) }
    end
  end
end
