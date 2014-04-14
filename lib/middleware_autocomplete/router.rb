module MiddlewareAutocomplete
  class Router
    def initialize(app)
      @app = app
    end

    def call(env)
      if (klass = ROUTES[env['REQUEST_PATH']])
        request = Rack::Request.new(env)
        result = ActiveRecord::Base.connection_pool.with_connection do
          klass.search(request.params)
        end
        [200, { 'Content-Type' => klass.content_type_string }, [result]]
      else
        @app.call(env)
      end
    end

  end
end