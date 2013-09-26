# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'urchin_tracking_module/version'

Gem::Specification.new do |spec|
  spec.name          = "urchin_tracking_module"
  spec.version       = UrchinTrackingModule::VERSION
  spec.authors       = ["Jan Riethmayer"]
  spec.email         = ["jan@riethmayer.de"]
  spec.description   = %q{Add Google Analytics urchin tracking module params to your URLs. It's the [Google Analytics URL builder](https://support.google.com/analytics/answer/1033867?hl=en) as a gem.}
  spec.summary       = %q{utm params for your URL.}
  spec.homepage      = "http://github.com/bonusboxme/urchin_tracking_module"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
