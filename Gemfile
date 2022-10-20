source ENV['GEM_SOURCE'] || 'https://rubygems.org'

gemspec

group :release do
  gem 'github_changelog_generator', require: false
  gem 'faraday-retry', '~> 2.0.0', require: false
end

group :coverage, optional: ENV['COVERAGE']!='yes' do
  gem 'simplecov-console', :require => false
  gem 'codecov', :require => false
end

group :rubocop do
  gem 'rubocop', '~> 1.6.1', require: false
  gem 'rubocop-rspec', '~> 2.0.1', require: false
  gem 'rubocop-performance', '~> 1.9.1', require: false
end
