module StrongRoutes
  class RouteMatcher < Regexp
    def initialize(route)
      if route.is_a?(Regexp)
        super(route)
      else
        route = map_dynamic_segments(route)
        route = "/#{route}" unless route =~ /\A\//
        escaped_route = Regexp.escape(route)
        super(/\A#{route}/i)
      end
    end

    private

    # Replace dynamic segments in the route with wildcards (e.g. /:foo/users/:id
    # becomes /.*/users/.*)
    #
    def map_dynamic_segments(route)
      route.to_s.gsub(/:\w+/, '.*')
    end
  end
end
