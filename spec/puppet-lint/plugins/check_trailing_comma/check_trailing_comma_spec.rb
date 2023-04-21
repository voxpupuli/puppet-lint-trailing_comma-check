require 'spec_helper'

describe 'trailing_comma' do
  let(:msg) { 'missing trailing comma after last element' }

  context 'with fix disabled' do
    context 'trailing comma present' do
      let(:code) do
        <<-EOS
        class { '::apache':
          timeout => '100',
          docroot => '/var/www',
          Enum[
            'a',
            'b',
            'c'
          ] $test = 'c',
        }

        class{ '::nginx': }

        file { '/etc/fstab':
          ensure  => 'file',
          content => 'foo',
        }

        file { '/tmp/foo': }

        file { '/tmp/bar':
           ensure => file;
        }

        resources { 'sshkey': purge => true }

        user { 'elmo':
          groups => [
            'foo',
            'bar',
            ],
          groupss => ['baz', 'qux'],
          groupz  => [
          ],
        }

        File {
          owner => root,
          group => '0',
        }

        $foo = {
          'bar' => {
            baz  => 'abc',
            bazz => 'def',
          },
          'qux' => 'ghi',
        }

        service { 'bar':
          subscribe => File[
            '/etc/baz.conf', '/etc/baz.conf.d'
             ],
        }

        function myfunc (
          Mymod::Mytype $arg1,
          String[1] $arg2,
        ) >> Mymod::Mytype {
          notice('foo')
        }

        if $var =~ Sensitive {
          $foo = $var.unwrap
        }

        if $var !~ Mymodule::MyType {
          fail("encountered error ${err}")
        }

        $test = [
          'a',
          'b',
          'c',
        ],
        EOS
      end

      it 'does not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'trailing comma absent' do
      let(:code) do
        <<-EOS
        class { '::apache':
          timeout => '100',
          docroot => '/var/www',
          Enum[
            'a',
            'b',
            'c'
          ] $test = 'c'
        }

        class{ '::nginx': }

        file { '/etc/fstab':
          ensure  => 'file',
          content => 'foo'
        }

        file { '/tmp/foo': }

        file { '/tmp/bar':
           ensure => file;
        }

        resources { 'sshkey': purge => true }

        user { 'elmo':
          groups  => [
            'foo',
            'bar'
            ],
          groupss => ['baz', 'qux'],
          groupz  => [
          ],
        }

        File {
          owner => root,
          group => '0'
        }

        $foo = {
          'bar' => {
            baz  => 'abc',
            bazz => 'def'
          },
          'qux' => 'ghi'
        }

        service { 'bar':
          subscribe => File[
            '/etc/baz.conf', '/etc/baz.conf.d'
             ],
        }

        $test = [
          'a',
          'b',
          'c'
        ]
        EOS
      end

      it 'detects 7 problems' do
        expect(problems).to have(7).problems
      end

      it 'creates warnings' do
        expect(problems).to contain_warning(msg).on_line(8).in_column(24)
        expect(problems).to contain_warning(msg).on_line(15).in_column(27)
        expect(problems).to contain_warning(msg).on_line(29).in_column(18)
        expect(problems).to contain_warning(msg).on_line(38).in_column(23)
        expect(problems).to contain_warning(msg).on_line(44).in_column(26)
        expect(problems).to contain_warning(msg).on_line(46).in_column(25)
        expect(problems).to contain_warning(msg).on_line(58).in_column(14)
      end
    end

    context 'with heredoc' do
      context 'with trailing comma' do
        let(:code) do
          <<-EOS
          file { '/tmp/test.txt':
            ensure  => 'file',
            content => @(EOT),
              Hello
              World
              EOT
          }

          file { '/tmp/test2.txt':
            ensure  => 'file',
            content => @("FRAGMENT"),
              ${var1}
              some text
              ${var2}
              | FRAGMENT
          }
          EOS
        end

        it 'does not detect any problems' do
          expect(problems).to have(0).problems
        end
      end

      context 'without trailing comma' do
        let(:code) do
          <<-EOS
          file { '/tmp/test.txt':
            ensure  => 'file',
            content => @(EOT)
              Hello
              World
            EOT
          }

          file { '/tmp/test2.txt':
            ensure  => 'file',
            content => @("FRAGMENT")
              ${var1}
              some text
              ${var2}
              | FRAGMENT
          }
          EOS
        end

        it 'detects a problem' do
          expect(problems).to have(2).problems
        end

        it 'creates a warning' do
          expect(problems).to contain_warning(msg).on_line(3).in_column(30)
          expect(problems).to contain_warning(msg).on_line(11).in_column(37)
        end
      end
    end
  end

  context 'with fix enabled' do
    before do
      PuppetLint.configuration.fix = true
    end

    after do
      PuppetLint.configuration.fix = false
    end

    context 'trailing comma present' do
      let(:code) do
        <<-EOS
        class { '::apache':
          timeout => '100',
          docroot => '/var/www',
          Enum[
            'a',
            'b',
            'c'
          ] $test = 'c',
        }

        class{ '::nginx': }

        file { '/etc/fstab':
          ensure  => 'file',
          content => 'foo',
        }

        file { '/tmp/foo': }

        file { '/tmp/bar':
           ensure => file;
        }

        resources { 'sshkey': purge => true }

        user { 'elmo':
          groups => [
            'foo',
            'bar',
            ],
          groupss => ['baz', 'qux'],
          groupz  => [
          ],
        }

        File {
          owner => root,
          group => '0',
        }

        $foo = {
          'bar' => {
            baz  => 'abc',
            bazz => 'def',
          },
          'qux' => 'ghi',
        }

        service { 'bar':
          subscribe => File[
            '/etc/baz.conf', '/etc/baz.conf.d'
             ],
        }

        $test = [
          'a',
          'b',
          'c',
        ],
        EOS
      end

      it 'does not detect any problems' do
        expect(problems).to have(0).problems
      end

      it 'does not modify the manifest' do
        expect(manifest).to eq(code)
      end
    end

    context 'trailing comma absent' do
      let(:code) do
        <<-EOS
        class { '::apache':
          timeout => '100',
          docroot => '/var/www',
          Enum[
            'a',
            'b',
            'c'
          ] $test = 'c'
        }

        class{ '::nginx': }

        file { '/etc/fstab':
          ensure  => 'file',
          content => 'foo'
        }

        file { '/tmp/foo': }

        file { '/tmp/bar':
           ensure => file;
        }

        resources { 'sshkey': purge => true }

        user { 'elmo':
          groups => [
            'foo',
            'bar'
            ],
          groupss => ['baz', 'qux'],
          groupz  => [
          ],
        }

        File {
          owner => root,
          group => '0'
        }

        $foo = {
          'bar' => {
            baz  => 'abc',
            bazz => 'def'
          },
          'qux' => 'ghi'
        }

        service { 'bar':
          subscribe => File[
            '/etc/baz.conf', '/etc/baz.conf.d'
             ],
        }

        $test = [
          'a',
          'b',
          'c'
        ]
        EOS
      end

      it 'detects 7 problems' do
        expect(problems).to have(7).problems
      end

      it 'creates a warning' do
        expect(problems).to contain_fixed(msg).on_line(8).in_column(24)
        expect(problems).to contain_fixed(msg).on_line(15).in_column(27)
        expect(problems).to contain_fixed(msg).on_line(29).in_column(18)
        expect(problems).to contain_fixed(msg).on_line(38).in_column(23)
        expect(problems).to contain_fixed(msg).on_line(44).in_column(26)
        expect(problems).to contain_fixed(msg).on_line(46).in_column(25)
        expect(problems).to contain_fixed(msg).on_line(58).in_column(14)
      end

      it 'adds trailing commas' do
        expect(manifest).to eq(
          <<-EOS,
        class { '::apache':
          timeout => '100',
          docroot => '/var/www',
          Enum[
            'a',
            'b',
            'c'
          ] $test = 'c',
        }

        class{ '::nginx': }

        file { '/etc/fstab':
          ensure  => 'file',
          content => 'foo',
        }

        file { '/tmp/foo': }

        file { '/tmp/bar':
           ensure => file;
        }

        resources { 'sshkey': purge => true }

        user { 'elmo':
          groups => [
            'foo',
            'bar',
            ],
          groupss => ['baz', 'qux'],
          groupz  => [
          ],
        }

        File {
          owner => root,
          group => '0',
        }

        $foo = {
          'bar' => {
            baz  => 'abc',
            bazz => 'def',
          },
          'qux' => 'ghi',
        }

        service { 'bar':
          subscribe => File[
            '/etc/baz.conf', '/etc/baz.conf.d'
             ],
        }

        $test = [
          'a',
          'b',
          'c',
        ]
        EOS
        )
      end
    end

    context 'with heredoc' do
      context 'with trailing comma' do
        let(:code) do
          <<-EOS
          file { '/tmp/test.txt':
            ensure  => 'file',
            content => @(EOT),
              Hello
              World
              EOT
          }

          file { '/tmp/test2.txt':
            ensure  => 'file',
            content => @("FRAGMENT"),
              ${var1}
              some text
              ${var2}
              | FRAGMENT
          }
          EOS
        end

        it 'does not detect any problems' do
          expect(problems).to have(0).problems
        end

        it 'does not modify the manifest' do
          expect(manifest).to eq(code)
        end
      end

      context 'without trailing comma' do
        let(:code) do
          <<-EOS
          file { '/tmp/test.txt':
            ensure  => 'file',
            content => @(EOT)
              Hello
              World
            EOT
          }

          file { '/tmp/test2.txt':
            ensure  => 'file',
            content => @("FRAGMENT")
              ${var1}
              some text
              ${var2}
              | FRAGMENT
          }
          EOS
        end

        it 'detects a problem' do
          expect(problems).to have(2).problems
        end

        it 'creates a warning' do
          expect(problems).to contain_fixed(msg).on_line(3).in_column(30)
          expect(problems).to contain_fixed(msg).on_line(11).in_column(37)
        end

        it 'adds trailing commas' do
          expect(manifest).to eq(
            <<-EOS,
          file { '/tmp/test.txt':
            ensure  => 'file',
            content => @(EOT),
              Hello
              World
            EOT
          }

          file { '/tmp/test2.txt':
            ensure  => 'file',
            content => @("FRAGMENT"),
              ${var1}
              some text
              ${var2}
              | FRAGMENT
          }
          EOS
          )
        end
      end
    end
  end
end
