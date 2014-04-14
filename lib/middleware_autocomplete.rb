require "middleware_autocomplete/engine"

module MiddlewareAutocomplete
  autoload :Base, 'middleware_autocomplete/base'
  autoload :Router, 'middleware_autocomplete/router'

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
end