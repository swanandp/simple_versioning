# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_versioning/version"

Gem::Specification.new do |s|
  s.name        = "simple_versioning"
  s.version     = SimpleVersioning::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Swanand Pagnis"]
  s.email       = ["swanand@kaverisoft.com"]
  s.homepage    = "http://github.com/spp/simple_versioning"
  s.summary     = %q{Provide a vanilla versioning support}
  s.description = %q{Keeps track of your models attributes}

  s.rubyforge_project = "simple_versioning"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activerecord', '>= 2.2.2'
end
