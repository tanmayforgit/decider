$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "decider/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "decider"
  s.version     = Decider::VERSION
  s.authors     = ["Tanmay Tupe"]
  s.email       = ["tanmaytupe@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Decider."
  s.description = "TODO: Description of Decider."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"

  s.add_development_dependency "sqlite3"
end
