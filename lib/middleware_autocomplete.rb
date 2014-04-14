require "middleware_autocomplete/engine"

module MiddlewareAutocomplete
  autoload :Base,       'middleware_autocomplete/base'
  autoload :Router,     'middleware_autocomplete/router'
  autoload :UrlHelpers, 'middleware_autocomplete/url_helpers'

  # Path namespace for autocompletes
  mattr_accessor :namespace
  @@namespace = '/autocompletes'

  # Default content_type
  mattr_accessor :content_type
  @@content_type = :json

  ROUTES = ActiveSupport::OrderedHash.new

  def self.setup
    yield self
  end

  def self.load_routes
    Base.descendants.each do |klass|
      ROUTES[klass.route] = klass
    end

    UrlHelpers.generate_helpers!
    Rails.application.routes.named_routes.module.include(UrlHelpers)
  end
end