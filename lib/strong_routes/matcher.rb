# frozen_string_literal: true

module StrongRoutes
  class Matcher < Regexp
    def initialize(route)
      if route.is_a?(Regexp)
        super
      else
        escaped_route = Regexp.escape(route)
        # Replace dynamic segments in the route with wildcards (e.g. /:foo/users/:id becomes /.*/users/.*)
        escaped_route.gsub!(/:\w+/, ".*")
        super(/\A#{escaped_route}/i)
      end
    end
  end
end
