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

      def map
        matches.map { |match_data| match_data[:path] }
      end

      def matches
        matches = paths.map { |path| path.match(/\A\/(?<path>\w+)\/*.*\Z/) }
        matches.compact!
        matches.uniq!
        matches
      end

      def paths
        paths = routes.map { |route| ::ActionDispatch::Routing::RouteWrapper.new(route).path }
        paths.uniq!
        paths
      end

      def routes
        route_set.routes
      end
    end
  end
end
