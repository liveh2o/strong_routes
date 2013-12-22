require 'strong_routes/rails/route_mapper'

module StrongRoutes
  module Rails
    class Railtie < ::Rails::Railtie
      config.strong_routes = ::StrongRoutes.config

      initializer 'strong_routes.initialize' do |app|
        config.allowed_routes ||= []
        config.allowed_routes += ::StrongRoutes::Rails::RouteMapper.map(app.routes)

        case
        when config.strong_routes.insert_before? then
          app.config.middleware.insert_before(config.strong_routes.insert_before, ::StrongRoutes::Allow)
        when config.strong_routes.insert_after? then
          app.config.middleware.insert_after(config.strong_routes.insert_after, ::StrongRoutes::Allow)
        else
          app.config.middleware.insert_before(::Rails::Rack::Logger, ::StrongRoutes::Allow)
        end
      end
    end
  end
end
