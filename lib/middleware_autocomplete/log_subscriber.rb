module MiddlewareAutocomplete
  class LogSubscriber < ActiveSupport::LogSubscriber
    def perform(event)
      info "#{GREEN}#{BOLD}[MiddlewareAutocomplete]#{CLEAR} Completed 200 OK in #{event.duration.round(3)} ms"
    end
  end
end

MiddlewareAutocomplete::LogSubscriber.attach_to :middleware_autocomplete