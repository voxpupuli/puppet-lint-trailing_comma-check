Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-trailing_comma-check'
  spec.version     = '0.4.0'
  spec.homepage    = 'https://github.com/puppet-community/puppet-lint-trailing_comma-check'
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

  spec.add_dependency             'puppet-lint', '~> 2.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'mime-types', '~> 1.0' # 2.x dropped Ruby 1.8 support
  spec.add_development_dependency 'coveralls', '~> 0.7' unless RUBY_VERSION =~ /^1\.8/
  spec.add_development_dependency 'rake'
end
