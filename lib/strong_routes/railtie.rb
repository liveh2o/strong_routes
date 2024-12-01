# frozen_string_literal: true

require "strong_routes/route_mapper"

module StrongRoutes
  class Railtie < Rails::Railtie
    config.strong_routes = StrongRoutes.config

    initializer "strong_routes.initialize" do |app|
      if config.strong_routes.insert_before?
        app.config.middleware.insert_before(config.strong_routes.insert_before, Allow)
      elsif config.strong_routes.insert_after?
        app.config.middleware.insert_after(config.strong_routes.insert_after, Allow)
      else
        app.config.middleware.insert_before(Rails::Rack::Logger, Allow)
      end

      if config.strong_routes.content.blank?
        file_name = Rails.root.join("public/404.html")
        if File.exist?(file_name)
          config.strong_routes.content = File.read(file_name)
          config.strong_routes.content_type = "text/html"
        end
      end
    end

    # Added in 7.1, but fixed in 7.1.3 to run whenever routes are re/loaded
    # https://github.com/rails/rails/issues/50720
    if config.respond_to?(:after_routes_loaded)
      config.after_routes_loaded do
        config.strong_routes.allowed_routes = RouteMapper.map(Rails.application.routes)
      end
    else
      config.after_initialize do |app|
        # Need to force Rails to load the routes since there's no way to hook
        # in after routes are loaded
        app.reload_routes!
        config.strong_routes.allowed_routes = RouteMapper.map(app.routes)
      end
    end
  end
end
