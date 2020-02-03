$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "nayati/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nayati"
  s.version     = Nayati::VERSION
  s.authors     = ["Tanmay Tupe"]
  s.email       = ["tanmaytupe@gmail.com"]
  s.homepage    = "https://github.com/tanmayforgit/nayati"
  s.summary     = "Summary of Nayati."
  s.description = "Nayati is a Rails engine that helps in creating a clean and maintainable multi tenant Rails application. Creating multitenant application with Nayati allows you to have models that do just database talking and business logic gets handled by a layer I like to call 'Operation layer'. The sequence in which these operations get executed for a tenant is put in database."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_development_dependency 'rails', '~> 5.2', '>= 5.2.0'
  s.add_runtime_dependency 'activerecord'
  s.add_development_dependency 'mysql2', '~> 0'
  s.add_development_dependency 'rspec-rails', '~> 0'
  s.add_development_dependency 'factory_girl', '~> 0'
  s.add_development_dependency 'pry', '~> 0'
end
