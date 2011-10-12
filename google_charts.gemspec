# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "google_charts/version"

Gem::Specification.new do |s|
  s.name        = "google_charts"
  s.version     = GoogleCharts::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rudolf Schmidt"]
  
  s.homepage    = "http://github.com/rudionrails/google_charts"
  s.summary     = %q{Google Charts with Ruby}
  s.description = %q{GoogleCharts is a Ruby wrapper to the Google Chart API}

  s.rubyforge_project = "google_charts"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "actionpack", ">= 3.x"
end
