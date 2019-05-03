require File.expand_path("../lib/unite_rb/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "unite_rb".freeze
  s.version = UniteRb.version.freeze
  s.date = "2019-05-03".freeze
  s.platform = Gem::Platform::RUBY
  s.summary = "Bring units to Ruby variables"
  s.description = "This module enables attaching units to numeric variables. Relations between units can be specified,\nwhich furthers allow variables with different units to be compared, and arithmetic operations to be performed on them."
  s.author = "Marcelo Pereira"
  s.license = "MIT"
  s.metadata = {
    "source_code_uri" => "https://github.com/marcper/unite_rb",
  }
  s.homepage = "https://github.com/marcper/unite_rb".freeze
  s.files = %w(LICENSE README.md)
  s.require_path = "lib"
  s.add_development_dependency "rspec", "~> 3.4"
end
