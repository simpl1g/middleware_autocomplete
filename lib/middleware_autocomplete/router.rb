module MiddlewareAutocomplete
  class Router
    def initialize(app)
      @app = app
    end

    def call(env)
      if (klass = ROUTES[env['PATH_INFO']])
        ActiveSupport::Notifications.instrument 'perform.middleware_autocomplete' do
          result = klass.perform(Rack::Request.new(env).params)
          [200, { 'Content-Type' => klass.content_type_string }, [result]]
        end
      else
        @app.call(env)
      end
    end
  end
end