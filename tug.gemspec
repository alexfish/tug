# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tug/version'

Gem::Specification.new do |spec|
  spec.name          = "tug"
  spec.version       = Tug::VERSION
  spec.authors       = ["Alex Fish"]
  spec.email         = ["alex@alexefish.com"]
  spec.description   = "Build and deploy iOS project"
  spec.summary       = "iOS project builder and depoloyer"
  spec.homepage      = "https://github.com/alexfish/tug"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "rubyzip", "~> 1.1.6"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
end
