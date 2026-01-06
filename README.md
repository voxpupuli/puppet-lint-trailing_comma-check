puppet-lint-trailing_comma-check
=================================

[![License](https://img.shields.io/github/license/voxpupuli/puppet-lint-trailing_comma-check.svg)](https://github.com/voxpupuli/puppet-lint-trailing_comma-check/blob/master/LICENSE)
[![Test](https://github.com/voxpupuli/puppet-lint-trailing_comma-check/actions/workflows/test.yml/badge.svg)](https://github.com/voxpupuli/puppet-lint-trailing_comma-check/actions/workflows/test.yml)
[![Release](https://github.com/voxpupuli/puppet-lint-trailing_comma-check/actions/workflows/release.yml/badge.svg)](https://github.com/voxpupuli/puppet-lint-trailing_comma-check/actions/workflows/release.yml)
[![RubyGem Version](https://img.shields.io/gem/v/puppet-lint-trailing_comma-check.svg)](https://rubygems.org/gems/puppet-lint-trailing_comma-check)
[![RubyGem Downloads](https://img.shields.io/gem/dt/puppet-lint-trailing_comma-check.svg)](https://rubygems.org/gems/puppet-lint-trailing_comma-check)
[![Coverage Status](https://coveralls.io/repos/github/voxpupuli/puppet-lint-trailing_comma-check/badge.svg?branch=master)](https://coveralls.io/github/voxpupuli/puppet-lint-trailing_comma-check?branch=master)
[![Donated by Camptocamp](https://img.shields.io/badge/donated%20by-camptocamp-fb7047.svg)](#transfer-notice)

A puppet-lint plugin to check for missing trailing commas.

## Installing

### From the command line

```shell
$ gem install puppet-lint-trailing_comma-check
```

### In a Gemfile

```ruby
gem 'puppet-lint-trailing_comma-check', :require => false
```

## Checks

### Missing trailing comma

As per style guide v2.0, there must be trailing commas after all resource attributes and
parameter definitions.

#### What you have done

```puppet
file { '/etc/sudoers':
  ensure => file
}
```

```puppet
file { '/etc/file':
  ensure  => file,
  content => @(EOF)
  Content
  | EOF
}
```

#### What you should have done

```puppet
file { '/etc/sudoers':
  ensure => file,
}
```

```puppet
file { '/etc/file':
  ensure  => file,
  content => @(EOF),
  Content
  | EOF
}
```

#### Disabling the check

To disable this check, you can add `--no-trailing_comma-check` to your puppet-lint command line.

```shell
$ puppet-lint --no-trailing_comma-check path/to/file.pp
```

Alternatively, if you’re calling puppet-lint via the Rake task, you should insert the following line to your `Rakefile`.

```ruby
PuppetLint.configuration.send('disable_trailing_comma')
```

## Transfer Notice

This plugin was originally authored by [Camptocamp](http://www.camptocamp.com).
The maintainer preferred that Puppet Community take ownership of the module for future improvement and maintenance.
Existing pull requests and issues were transferred over, please fork and continue to contribute here instead of Camptocamp.

Previously: https://github.com/camptocamp/puppet-lint-trailing_comma-check

## License

This gem is licensed under the Apache-2 license.

## Release information

To make a new release, please do:
* update the version in the gemspec file
* Install gems with `bundle install --with release --path .vendor`
* generate the changelog with `bundle exec rake changelog`
* Check if the new version matches the closed issues/PRs in the changelog
* Create a PR with it
* After it got merged, push a tag. GitHub actions will do the actual release to rubygems and GitHub Packages
