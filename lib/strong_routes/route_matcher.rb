module StrongRoutes
  class RouteMatcher < Regexp
    def initialize(route)
      if route.is_a?(Regexp)
        super(route)
      else
        super(/\A\/#{route}/i,)
      end
    end
  end
end
