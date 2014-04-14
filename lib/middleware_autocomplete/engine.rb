module MiddlewareAutocomplete
  class Engine < ::Rails::Engine

    config.to_prepare do
      Dir.glob(Rails.root + "app/autocompletes/**/*_autocomplete.rb").each do |c|
        require_dependency(c)
      end
      MiddlewareAutocomplete::Base.setup
    end

    initializer 'middleware_autocomplete.connect_middleware_router' do |app|
      app.config.middleware.use 'MiddlewareAutocomplete::Router'
    end

  end
end
