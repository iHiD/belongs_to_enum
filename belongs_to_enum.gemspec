# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "belongs_to_enum/version"

Gem::Specification.new do |s|
  s.name        = "belongs_to_enum"
  s.version     = BelongsToEnum::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jeremy walker"]
  s.email       = ["jez.walker@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Adds support for transparent enums to ActiveRecord}
  s.description = %q{Adds a belongs_to_enum to ActiveRecord that takes an array of possible values.}

  s.rubyforge_project = "belongs_to_enum"
  
  s.add_dependency "rails"
  s.add_development_dependency "rspec-rails"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
