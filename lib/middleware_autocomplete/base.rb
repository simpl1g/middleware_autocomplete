module MiddlewareAutocomplete
  class Base
    class << self
      attr_accessor :namespace, :path, :route_name, :content_type, :search_key

      def setup
        autocomplete_klasses = descendants

        autocomplete_klasses.each do |klass|
          ROUTES[klass.route] = klass
        end

        # Add url helpers namespace_route_path
        Rails.application.routes.named_routes.module.module_eval do
          autocomplete_klasses.each do |klass|
            define_method "#{klass.route_name}_path" do
              klass.route
            end
          end
        end
      end

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