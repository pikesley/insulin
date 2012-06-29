# -*- encoding: utf-8 -*-
require File.expand_path('../lib/insulin/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sam"]
  gem.email         = ["sam@cruft.co"]
  gem.description   = %q{Dexcription}
  gem.summary       = %q{Summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "insulin"
  gem.require_paths = ["lib"]
  gem.version       = Insulin::VERSION

  gem.add_dependency "mongo"
  gem.add_dependency "bson_ext"

  gem.add_development_dependency "rspec", "~> 2.6"
end
