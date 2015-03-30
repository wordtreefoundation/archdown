# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'archdown/version'

Gem::Specification.new do |spec|
  spec.name          = "archdown"
  spec.version       = Archdown::VERSION
  spec.authors       = ["Duane Johnson","Peter Boling"]
  spec.email         = ["duane.johnson@gmail.com","peter.boling@gmail.com"]

  spec.summary       = %q{Command-line utility to download books from archive.org}
  spec.description   = %q{Command-line utility, and Ruby Library, to download books from archive.org using archivist-client}
  spec.homepage      = "http://blog.wordtree.org/2015/03/29/using-textgrams-jl/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  # end

  spec.add_dependency "archivist-client", "~> 0.1.0"
  spec.add_dependency "retriable", "~> 2.0.0"
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2.0"
end
