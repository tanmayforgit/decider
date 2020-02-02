$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "nayati/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nayati"
  s.version     = Decider::VERSION
  s.authors     = ["Tanmay Tupe"]
  s.email       = ["tanmaytupe@gmail.com"]
  # s.homepage    = "TODO"
  s.summary     = "Summary of Decider."
  # s.description = "TODO: Description of Decider."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_development_dependency "rails", "~> 5.2.0"
  s.add_runtime_dependency 'activerecord', '>= 3.2.0'
  s.add_development_dependency "mysql2"
  s.add_development_dependency  "rspec-rails"
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency "pry"
end
