$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nkss/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nkss-rails"
  s.version     = Nkss::VERSION
  s.authors     = ["Rico Sta. Cruz", "Nadarei, Inc."]
  s.email       = ["rico@ambiescent.com"]
  s.homepage    = "http://nadarei.co/nkss-rails"
  s.summary     = "Create pretty styleguides for your Rails 3.2 projects."
  s.description = "Nkss-rails is a drop-in, easy-to-use, gorgeous-by-default Rails plugin you can put into your
projects so you can instantly have cute docs."

  s.files = Dir["{app,config,lib}/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.0"

  s.add_dependency "kss"
  s.add_dependency "ffaker"
  s.add_dependency "BlueCloth"
end
