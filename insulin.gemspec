# -*- encoding: utf-8 -*-
require File.expand_path('../lib/insulin/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sam"]
  gem.email         = ["sam@cruft.co"]
  gem.description   = %q{Take exported CSV from the OnTrack diabetes app, put it into MongoDB, and do interesting stuff with it}
  gem.summary       = %q{Doing stuff with my diabetes data}
  gem.homepage      = "http://pikesley.github.com/insulin/"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "insulin"
  gem.require_paths = ["lib"]
  gem.version       = Insulin::VERSION

  gem.executables << 'insulin'

  gem.add_dependency "thor"
  gem.add_dependency "mongo"
  gem.add_dependency "bson_ext"
  gem.add_dependency "ffi"

  gem.add_development_dependency "rspec", "~> 2.6"
  gem.add_development_dependency "cucumber"
  gem.add_development_dependency "aruba"
  gem.add_development_dependency "gem-release"
end
