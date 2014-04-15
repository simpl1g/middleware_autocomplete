# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter 'test'
end

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# if ActiveSupport::TestCase.method_defined?(:fixture_path=)
#   ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
# end

# # Load fixtures from the engine
# ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)

class ActiveSupport::TestCase
  fixtures :all
end
