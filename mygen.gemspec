# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mygen/version'

Gem::Specification.new do |spec|
  spec.name          = "mygen"
  spec.version       = Mygen::VERSION
  spec.authors       = ["Kristian Rasmussen"]
  spec.email         = ["me@krx.io"]

  spec.summary       = %q{Code generator for generating project structures,
  for various languages}
  spec.description   = %q{Code generator that helps you generating project
  structures, filtering files. Plugable in a git like manner.}
  spec.homepage      = "https://github.com/iamkristian/mygen"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/myg}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "gli", "~> 2.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "pry-byebug", "~> 3.3"
end
