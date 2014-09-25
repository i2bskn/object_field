# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'object_field/version'

Gem::Specification.new do |spec|
  spec.name          = "object_field"
  spec.version       = ObjectField::VERSION
  spec.authors       = ["i2bskn"]
  spec.email         = ["i2bskn@gmail.com"]
  spec.summary       = %q{Support for object persistence.}
  spec.description   = %q{Support for object persistence.}
  spec.homepage      = "https://github.com/i2bskn/object_field"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "oj"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  # spec.add_development_dependency "rspec"
  # spec.add_development_dependency "coveralls"
  # spec.add_development_dependency "simplecov"
end

