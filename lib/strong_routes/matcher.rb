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

        # (:?\?.*)*$ matches the end of the string OR a '?' followed by anything until the end of string
        # validation of query params is left to the app, but this at least prevents a route such as "/"
        # from matching "/foo" while still allowing query params
        super(/\A#{escaped_route}(:?\?.*)*$/i)
      end
    end
  end
end
