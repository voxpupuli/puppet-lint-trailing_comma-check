Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-trailing_comma-check'
  spec.version     = '0.4.1'
  spec.homepage    = 'https://github.com/voxpupuli/puppet-lint-trailing_comma-check'
  spec.license     = 'Apache-2.0'
  spec.author      = 'Puppet Community'
  spec.email       = 'raphael.pinson@camptocamp.com'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = 'A puppet-lint plugin to check for missing trailing commas.'
  spec.description = <<-EOF
    A puppet-lint plugin to check for missing trailing commas.
  EOF

  spec.required_ruby_version = Gem::Requirement.new(">= 2.0".freeze)

  spec.add_dependency             'puppet-lint', '>= 1.0', '< 3.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'mime-types'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rake'
end
