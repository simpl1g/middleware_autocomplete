require "middleware_autocomplete/version"

module MiddlewareAutocomplete
  autoload :Base, 'middleware_autocomplete/base'
  autoload :Router, 'middleware_autocomplete/router'

  # Path namespace for autocompletes
  mattr_accessor :namespace
  @@namespace = '/autocompletes'

  # Default content_type
  mattr_accessor :content_type
  @@namespace = :json

  ROUTES = ActiveSupport::OrderedHash.new
end

Dir[Rails.root.join 'app', 'autocompletes', '*.rb'].each { |f| require f }

MiddlewareAutocomplete::Base.setup
