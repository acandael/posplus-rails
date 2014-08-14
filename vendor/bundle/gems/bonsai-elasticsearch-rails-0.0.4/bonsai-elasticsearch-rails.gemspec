# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bonsai/elasticsearch/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "bonsai-elasticsearch-rails"
  spec.version       = Bonsai::Elasticsearch::Rails::VERSION
  spec.authors       = ["Rob Sears"]
  spec.email         = ["rc.sears@gmail.com"]
  spec.summary       = %q{Integrate your elasticsearch-rails gem with bonsai.}
  spec.description   = %q{Integrate your elasticsearch-rails gem with bonsai.}
  spec.homepage      = "http://bonsai.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "elasticsearch-rails"
end
