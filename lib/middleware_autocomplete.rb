require "middleware_autocomplete/engine"
require "middleware_autocomplete/log_subscriber"

module MiddlewareAutocomplete
  autoload :Base,       'middleware_autocomplete/base'
  autoload :Router,     'middleware_autocomplete/router'
  autoload :UrlHelpers, 'middleware_autocomplete/url_helpers'

  # Path namespace for autocompletes
  mattr_accessor :namespace
  @@namespace = 'autocomplete'

  # Default content_type
  mattr_accessor :content_type
  @@content_type = :json

  # Wraps search requests with ActiveRecord::Base.connection_pool.with_connection
  # It opens and closes connection to db when required
  # If you are using AR to get search results keep it turned on
  mattr_accessor :use_with_connection
  @@use_with_connection = true

  # Default cache store
  mattr_accessor :cache
  @@cache = Rails.cache

  # Default cache expiring time
  mattr_accessor :expire_in
  @@expire_in = 15.minutes

  ROUTES = ActiveSupport::OrderedHash.new

  class << self
    def setup
      yield self
    end

    def load_routes
      Base.descendants.each do |klass|
        ROUTES[klass.route] = klass
      end

      UrlHelpers.generate_helpers!
      Rails.application.routes.named_routes.module.send(:include, UrlHelpers)
    end
  end
end