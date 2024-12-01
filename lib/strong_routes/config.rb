# frozen_string_literal: true

module StrongRoutes
  class Config
    attr_accessor :enabled,
      :content,
      :content_type,
      :insert_after,
      :insert_before

    attr_reader :allowed_routes, :route_matchers
    attr_writer :status

    def initialize
      @allowed_routes = Set.new
      @enabled = true
      @route_matchers = []
    end

    def allowed_routes=(value)
      raise TypeError, "allowed routes must be an Enumerable" unless value.is_a?(Enumerable)
      @allowed_routes = value.to_set
      @route_matchers = allowed_routes.map { |route| StrongRoutes::Matcher.new(route) }
    end

    def enabled?
      !!enabled
    end

    def headers
      if content.present?
        {Rack::CONTENT_TYPE => content_type || "text/plain"}
      else
        {}
      end
    end

    def insert_after?
      !!insert_after
    end

    def insert_before?
      !!insert_before
    end

    def status
      @status ||= 404
    end
  end
end
