require "strong_routes/rails/route_mapper"

module StrongRoutes
  module Rails
    class Railtie < ::Rails::Railtie
      config.strong_routes = StrongRoutes.config

      initializer "strong_routes.initialize" do |app|
        if config.strong_routes.insert_before?

          app.config.middleware.insert_before(config.strong_routes.insert_before, Allow)
        elsif config.strong_routes.insert_after?

          app.config.middleware.insert_after(config.strong_routes.insert_after, Allow)
        else
          app.config.middleware.insert_before(::Rails::Rack::Logger, Allow)
        end
      end

      # Load this late so initializers that depend on routes have a chance to
      # initialize (i.e. Devise)
      config.after_initialize do |app|
        # Need to force Rails to load the routes since there's no way to hook
        # in after routes are loaded
        app.reload_routes!

        config.strong_routes.allowed_routes ||= []
        config.strong_routes.allowed_routes += RouteMapper.map(app.routes)
      end
    end
  end
end
