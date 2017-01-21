# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'console_tetris/version'

Gem::Specification.new do |spec|
  spec.name          = "console-tetris"
  spec.version       = ConsoleTetris::VERSION
  spec.authors       = ["pekepek"]
  spec.email         = ["ishihata@33i.co.jp"]

  spec.summary       = %q{you can play Tetris}
  spec.description   = %q{you can play Tetris}
  spec.homepage      = "https://github.com/pekepek/console-tetris"
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = spec.files.grep(%r{^bin/}) {|f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency 'io-console'
end
