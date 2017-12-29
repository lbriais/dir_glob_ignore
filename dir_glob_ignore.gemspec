# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dir_glob_ignore/version'

Gem::Specification.new do |spec|
  spec.name          = 'dir_glob_ignore'
  spec.version       = DirGlobIgnore::VERSION
  spec.authors       = ['Laurent B.']
  spec.email         = ['lbnetid+gh@gmail.com']

  spec.summary       = %q{An extension to Ruby Dir.glob with filtering options.}
  spec.description   = %q{An extension to Ruby Dir.glob with git-like "ignore" files.}
  spec.homepage      = 'https://github.com/lbriais/dir_glob_ignore.git'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
