module MiddlewareAutocomplete
  class Router
    def initialize(app)
      @app = app
    end

    def call(env)
      ROUTES.fetch(env['PATH_INFO'], @app).call(env)
    end
  end
end