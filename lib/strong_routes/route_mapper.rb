module StrongRoutes
  class RouteMapper
    attr_reader :route_set

    def self.map(route_set)
      route_mapper = new(route_set)
      route_mapper.map
    end

    def initialize(route_set)
      @route_set = route_set
    end

    # Map the route set to a collection of the top level segments.
    def map
      map = matches.map { |match_data| match_data[:path] }
      map.uniq!
      map
    end

    private

    # Convert the path strings into match data objects, capturing all segments
    # except optional ones (e.g. :format).
    def matches
      matches = paths.map { |path| path.match(/\A(?<path>[-:\w\/]+)\/*.*\Z/) }
      matches.uniq!
      matches
    end

    # Extract the route paths from the route objects so we have a simple
    # string to interact with.
    def paths
      paths = route_set.routes.map { |route| route.path.spec.to_s }
      paths.uniq!
      paths
    end
  end
end
