# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'impraise/worker/version'

Gem::Specification.new do |spec|
  spec.name          = 'impraise-worker'
  spec.version       = Impraise::Worker::VERSION
  spec.authors       = ['Bartek Jarocki']
  spec.email         = ['bartek@devops.dance']

  spec.summary       = 'Use inotify to produce/consume disque jobs'
  spec.homepage      = 'https://github.com/bjarocki/impraise-worker.git'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop', '~> 0.48'

  spec.add_runtime_dependency 'disc'
  spec.add_runtime_dependency 'rb-inotify'
  spec.add_runtime_dependency 'rethinkdb'
  spec.add_runtime_dependency 'thor'
end
