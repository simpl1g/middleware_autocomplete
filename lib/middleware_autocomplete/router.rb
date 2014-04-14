module MiddlewareAutocomplete
  class Router
    def initialize(app)
      @app = app
    end

    def call(env)
      if (klass = ROUTES[env['PATH_INFO']])
        result = klass.perform(Rack::Request.new(env).params)
        [200, { 'Content-Type' => klass.content_type_string }, [result]]
      else
        @app.call(env)
      end
    end
  end
end