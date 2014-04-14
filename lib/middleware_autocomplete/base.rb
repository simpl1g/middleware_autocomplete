module MiddlewareAutocomplete
  class Base
    class << self
      attr_accessor :namespace, :path, :route_name, :content_type, :search_key

      def route
        [namespace, path].join('/')
      end

      def path
        @path || default_path
      end

      def default_path
        name.demodulize.sub(/Autocomplete\Z/, '').underscore
      end

      def namespace
        @namespace || MiddlewareAutocomplete.namespace
      end

      def route_name
        @route_name || default_route_name
      end

      def default_route_name
        "autocomplete_#{default_path}"
      end

      def search
        raise NotImplementedError
      end

      def content_type
        @content_type || MiddlewareAutocomplete.content_type
      end

      def content_type_string
        Mime::Type.lookup_by_extension(content_type).to_s
      end
    end
  end
end