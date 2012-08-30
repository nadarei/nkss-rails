$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nkss/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nkss-rails"
  s.version     = Nkss::VERSION
  s.authors     = ["Rico Sta. Cruz", "Nadarei, Inc."]
  s.email       = ["rico@ambiescent.com"]
  s.homepage    = "http://github.com/nadarei/nadarei-styleguides"
  s.summary     = "TODO: Summary of NadareiStyleguidesRails."
  s.description = "TODO: Description of NadareiStyleguidesRails."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"

  s.add_dependency "kss"
  s.add_dependency "ffaker"
  s.add_dependency "BlueCloth"
end
