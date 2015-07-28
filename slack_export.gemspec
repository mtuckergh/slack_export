# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "slack_export/version"

Gem::Specification.new do |spec|
  spec.name          = "slack_export"
  spec.version       = SlackExport::VERSION
  spec.authors       = ["Michael Tucker"]
  spec.email         = ["mtucker@godaddy.com"]
  spec.summary       = %q{Export private Slack channels}
  spec.description   = %q{Export private Slack channels in the standard Slack export format}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rest-client", "~> 1.0"
  spec.add_runtime_dependency "rubyzip", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~>3.0"
end
