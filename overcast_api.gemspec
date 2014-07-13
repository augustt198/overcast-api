# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'overcast_api/version'

Gem::Specification.new do |spec|
  spec.name          = "overcast_api"
  spec.version       = OvercastAPI::VERSION
  spec.authors       = ["August"]
  spec.email         = ["augustt198@gmail.com"]
  spec.description   = %q{RubyGem for retrieving information from the Overcast Network website}
  spec.summary       = %q{Ruby wrapper for the Overcast Network Website}
  spec.homepage      = "https://github.com/augustt198/overcast-api"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency 'rake', '~> 0'
  spec.add_dependency 'httparty', '~> 0.13', '>= 0.13.1'
  spec.add_dependency 'nokogiri', '~> 1.6', '>= 1.6.2.1'
end
