# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'protector/cancan/version'

Gem::Specification.new do |spec|
  spec.name          = "protector-cancan"
  spec.version       = Protector::Cancan::VERSION
  spec.authors       = ["Boris Staal"]
  spec.email         = ["boris@staal.io"]
  spec.description   = %q{Integration layer between Protector and CanCan}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/inossidabile/protector-cancan"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "protector", ">= 0.5.3"
  spec.add_dependency "cancan"
  spec.add_dependency "activesupport"
end
