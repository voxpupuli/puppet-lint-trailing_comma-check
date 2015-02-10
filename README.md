puppet-lint-trailing_comma-check
=================================

[![Build Status](https://travis-ci.org/camptocamp/puppet-lint-trailing_comma-check.svg)](https://travis-ci.org/camptocamp/puppet-lint-trailing_comma-check)
[![Code Climate](https://codeclimate.com/github/camptocamp/puppet-lint-trailing_comma-check/badges/gpa.svg)](https://codeclimate.com/github/camptocamp/puppet-lint-trailing_comma-check)
[![Gem Version](https://badge.fury.io/rb/puppet-lint-trailing_comma-check.svg)](http://badge.fury.io/rb/puppet-lint-trailing_comma-check)
[![Coverage Status](https://img.shields.io/coveralls/camptocamp/puppet-lint-trailing_comma-check.svg)](https://coveralls.io/r/camptocamp/puppet-lint-trailing_comma-check?branch=master)

A puppet-lint plugin to check for missing trailing commas.


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
