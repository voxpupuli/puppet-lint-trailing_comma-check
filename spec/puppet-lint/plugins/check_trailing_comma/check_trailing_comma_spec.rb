require 'spec_helper'

describe 'trailing_comma' do
  let (:msg) { 'missing trailing comma after last element' }

  context 'with fix disabled' do
    context 'trailing comma present' do
      let (:code) {
        <<-EOS
        class { '::apache':
          timeout => '100',
          docroot => '/var/www',
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
        EOS
      }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'trailing comma absent' do
      let (:code) {
        <<-EOS
        class { '::apache':
          timeout => '100',
          docroot => '/var/www'
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
        EOS
      }

      it 'should detect 6 problems' do
        expect(problems).to have(6).problems
      end

      it 'should create warnings' do
        expect(problems).to contain_warning(msg).on_line(3).in_column(32)
        expect(problems).to contain_warning(msg).on_line(10).in_column(27)
        expect(problems).to contain_warning(msg).on_line(24).in_column(18)
        expect(problems).to contain_warning(msg).on_line(33).in_column(23)
        expect(problems).to contain_warning(msg).on_line(39).in_column(26)
        expect(problems).to contain_warning(msg).on_line(41).in_column(25)
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
      let (:code) {
        <<-EOS
        class { '::apache':
          timeout => '100',
          docroot => '/var/www',
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
        EOS
      }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end

      it 'should not modify the manifest' do
        expect(manifest).to eq(code)
      end
    end

    context 'trailing comma absent' do
      let (:code) {
        <<-EOS
        class { '::apache':
          timeout => '100',
          docroot => '/var/www'
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
        EOS
      }

      it 'should detect 6 problems' do
        expect(problems).to have(6).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_fixed(msg).on_line(3).in_column(32)
        expect(problems).to contain_fixed(msg).on_line(10).in_column(27)
        expect(problems).to contain_fixed(msg).on_line(24).in_column(18)
        expect(problems).to contain_fixed(msg).on_line(33).in_column(23)
        expect(problems).to contain_fixed(msg).on_line(39).in_column(26)
        expect(problems).to contain_fixed(msg).on_line(41).in_column(25)
      end

      it 'should add trailing commas' do
        expect(manifest).to eq(
          <<-EOS
        class { '::apache':
          timeout => '100',
          docroot => '/var/www',
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
          EOS
        )
      end
    end
  end
end
