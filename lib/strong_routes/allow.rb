module StrongRoutes
  class Allow
    def initialize(app)
      @app = app
    end

    def call(env)
      return @app.call(env) unless config.enabled?

      if StrongRoutes.allowed?(env[Rack::PATH_INFO].to_s)
        @app.call(env)
      else
        StrongRoutes.response
      end
    end

    private

    def config
      StrongRoutes.config
    end
  end
end
