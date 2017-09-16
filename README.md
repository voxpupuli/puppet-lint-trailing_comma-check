puppet-lint-trailing_comma-check
=================================

[![License](https://img.shields.io/github/license/voxpupuli/puppet-lint-trailing_comma-check.svg)](https://github.com/voxpupuli/puppet-lint-trailing_comma-check/blob/master/LICENSE)
[![Build Status](https://img.shields.io/travis/voxpupuli/puppet-lint-trailing_comma-check.svg)](https://travis-ci.org/voxpupuli/puppet-lint-trailing_comma-check)
[![Gem Version](https://img.shields.io/gem/v/puppet-lint-trailing_comma-check.svg)](https://rubygems.org/gems/puppet-lint-trailing_comma-check)
[![Gem Downloads](https://img.shields.io/gem/dt/puppet-lint-trailing_comma-check.svg)](https://rubygems.org/gems/puppet-lint-trailing_comma-check)
[![Coverage Status](https://coveralls.io/repos/github/voxpupuli/puppet-lint-trailing_comma-check/badge.svg?branch=master)](https://coveralls.io/github/voxpupuli/puppet-lint-trailing_comma-check?branch=master)
[![Dependency Status](https://gemnasium.com/badges/github.com/voxpupuli/puppet-lint-trailing_comma-check.svg)](https://gemnasium.com/github.com/voxpupuli/puppet-lint-trailing_comma-check)
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

#### What you should have done

```puppet
file { '/etc/sudoers':
  ensure => file,
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
