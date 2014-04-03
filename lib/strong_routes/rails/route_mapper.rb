require 'action_dispatch/routing/inspector'

module StrongRoutes
  module Rails
    class RouteMapper
      attr_reader :route_set

      def self.map(route_set)
        route_mapper = self.new(route_set)
        route_mapper.map
      end

      def initialize(route_set)
        @route_set = route_set
      end

      # Map the route set to a collection of the top level segments.
      def map
        map = matches.map { |match_data| match_data[:path] }
        map.compact!
        map.uniq!
        map
      end

    private

      # All we need for the allowed routes is the first segment (i.e. 'users'
      # from '/users/:user_id/posts(/:format)'). Convert the path strings into
      # match data objects.
      def matches
        matches = paths.map { |path| path.match(/\A\/(?<path>[\w-]+)\/*.*\Z/) }
        matches.compact!
        matches.uniq!
        matches
      end

      # Extract the route paths from the route objects so we have a simple
      # string to interact with.
      def paths
        paths = route_set.routes.map { |route| ::ActionDispatch::Routing::RouteWrapper.new(route).path }
        paths.uniq!
        paths
      end
    end
  end
end
