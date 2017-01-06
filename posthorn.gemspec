# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'posthorn/version'

Gem::Specification.new do |spec|
  spec.name          = "posthorn"
  spec.version       = Posthorn::VERSION
  spec.authors       = ["Patrick Franken", "AISLER B.V."]
  spec.email         = ["p.franken@aisler.net"]
  spec.summary       = "Easy access to Deutsche Post 1C4A webservice"
  spec.description   = "With this Gem it is possible to order pre-paid shipping stickers from the Deutsche Post. Payment is done through the so called \"Portokasse\", a prepaid wallet service. To use this Gem a registration for the \"Portokasse\" and the 1C4A webservice is necessary."
  spec.homepage      = "http://aisler.net"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'savon', '~> 2'
  spec.add_runtime_dependency 'countries', '~> 2'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "geminabox"
end
