module MiddlewareAutocomplete
  class Cache

    attr_accessor :prefix

    def initialize
      self.store = ::Rails.cache if defined?(::Rails.cache)
      @prefix = 'middleware_autocomplete'
    end

    attr_reader :store
    def store=(store)
      @store = StoreProxy.build(store)
    end

    def read(key)
      store.read("#{prefix}:#{key}")
    end

    def write(key, value, expires_in)
      store.write("#{prefix}:#{key}", value, :expires_in => expires_in)
    end

  end
end
