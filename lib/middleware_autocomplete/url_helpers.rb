module MiddlewareAutocomplete
  module UrlHelpers
    def self.remove_helpers!
      self.instance_methods.map(&:to_s).grep(/_(url|path)$/).each do |method|
        remove_method method
      end
    end

    def self.generate_helpers!
      # Add url helpers namespace_route_path
      MiddlewareAutocomplete::ROUTES.each do |route_path, klass|
        define_method "#{klass.route_name}_path" do
          route_path
        end
      end
    end
  end
end