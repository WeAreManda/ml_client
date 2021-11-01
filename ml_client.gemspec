# frozen_string_literal: true

require_relative 'lib/ml_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'ml_client'
  spec.version       = MLClient::VERSION
  spec.authors       = ['Nicolas Goyet']
  spec.email         = ['nicolas@flatlooker.com']

  spec.summary       = 'This gem is a thin client for MLServer'
  spec.homepage      = 'https://github.com/Flatlooker/ml_client'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')
  spec.add_development_dependency 'minitest', '>= 5.14'
  spec.add_development_dependency 'vcr', '~> 6.0'
  spec.add_development_dependency 'webmock', '~> 3.12'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Flatlooker/ml_client'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
