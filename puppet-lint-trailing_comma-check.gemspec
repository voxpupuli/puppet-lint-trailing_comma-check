Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-trailing_comma-check'
  spec.version     = '3.0.0'
  spec.homepage    = 'https://github.com/voxpupuli/puppet-lint-trailing_comma-check'
  spec.license     = 'Apache-2.0'
  spec.author      = 'Vox Pupuli'
  spec.email       = 'voxpupuli@groups.io'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
    'CHANGELOG.md',
  ]
  spec.summary     = 'A puppet-lint plugin to check for missing trailing commas.'
  spec.description = <<-EOF
    A puppet-lint plugin to check for missing trailing commas.
  EOF

  spec.required_ruby_version = '>= 3.2'

  spec.add_dependency 'puppet-lint', '~> 5.1'
end
