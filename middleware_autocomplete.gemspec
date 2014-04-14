$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "middleware_autocomplete/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "middleware_autocomplete"
  s.version     = MiddlewareAutocomplete::VERSION
  s.authors     = ["Konstantin Ilchenko"]
  s.email       = ["konstantin@ilchenko.by"]
  s.homepage    = "http://github.com/simpl1g/middleware_autocomplete"
  s.summary     = "Fast autocomplete for Rails."
  s.description = "Generates autocomplete response straight from your middleware for Rails"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.2"
  s.add_dependency "activerecord", ">= 3.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"
  s.add_development_dependency "coveralls"
end
