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
        [404, {"Content-Type" => "text/html", "Content-Length" => config.message.length.to_s}, [config.message]]
      end
    end

    private

    def config
      StrongRoutes.config
    end
  end
end
