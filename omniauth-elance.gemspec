# -*- encoding: utf-8 -*-
require File.expand_path("../lib/omniauth-elance/version", __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency "omniauth-oauth2", "~> 1.1.1"

  gem.authors           = ["Jignesh Gohel"]
  gem.email             = ["jignesh.gohel@botreeconsulting.com"]
  gem.description       = %q{Elance strategy for OmniAuth.}
  gem.summary           = %q{Elance strategy for OmniAuth.}
  gem.homepage          = "https://github.com/JigneshGohel-BoTreeConsulting/omniauth-elance"
  gem.license           = "MIT"

  gem.executables       = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files             = `git ls-files`.split("\n")
  gem.test_files        = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name              = "omniauth-elance"
  gem.require_paths     = ["lib"]
  gem.version           = OmniAuth::Elance::VERSION
end
