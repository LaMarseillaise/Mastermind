# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mastermind/version'

Gem::Specification.new do |spec|
  spec.name          = "mastermind"
  spec.version       = Mastermind::VERSION
  spec.authors       = ["Andur Carr"]
  spec.email         = ["carr.andur@gmail.com"]

  spec.summary       = %q{An API for creating the game "Mastermind".}
  spec.description   = %q{An API for creating the game "Mastermind".}
  spec.homepage      = "https://github.com/lamarseillaise/mastermind"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = ["mastermind"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
