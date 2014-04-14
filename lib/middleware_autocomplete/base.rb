module MiddlewareAutocomplete
  class Base
    class << self
      attr_accessor :namespace, :path, :route_name, :content_type, :search_key

      # Calls user defined method to return results
      # Wraps this method with AR with_connection to prevent connection leaks
      #
      # ==== Attributes
      #
      # * +params+ - Params hash passed to request
      def perform(params)
        if use_with_connection
          with_connection { search(params) }
        else
          search(params)
        end
      end

      # Full path to the Autocomplete class
      def route
        [namespace, path].join('/')
      end

      # Path without namespace
      def path
        @path || default_path
      end

      # Route name to access Autocomplete search, e.g. autocomplete_posts_path
      def route_name
        @route_name || default_route_name
      end

      def namespace
        @namespace || MiddlewareAutocomplete.namespace
      end

      def use_with_connection
        @use_with_connection || MiddlewareAutocomplete.use_with_connection
      end

      # Returns search results for autocompletition
      # Result should be in the same format that your content_type
      # Should be defined by user
      def search(params)
        raise NotImplementedError
      end

      # Content type symbol, e.g. :json, :xml
      def content_type
        @content_type || MiddlewareAutocomplete.content_type
      end

      # Content type string, e.g. 'application/json', 'application/xml'
      def content_type_string
        Mime::Type.lookup_by_extension(content_type).to_s
      end

      private

      def default_route_name
        "autocomplete_#{default_path}"
      end

      def default_path
        name.demodulize.sub(/Autocomplete\Z/, '').underscore
      end

      def with_connection
        ActiveRecord::Base.connection_pool.with_connection do
          yield
        end
      end
    end
  end
end