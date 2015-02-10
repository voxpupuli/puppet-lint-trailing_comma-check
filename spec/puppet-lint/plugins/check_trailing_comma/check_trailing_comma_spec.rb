require 'spec_helper'

describe 'trailing_comma' do
  let (:msg) { 'missing trailing comma after last parameter' }

  context 'with fix disabled' do
    context 'trailing comma present' do
      let (:code) {
        <<-EOS
        class { '::apache':
          timeout => '100',
          docroot => '/var/www',
        }

        file { '/etc/fstab':
          ensure  => 'file',
          content => 'foo',
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

        file { '/etc/fstab':
          ensure  => 'file',
          content => 'foo'
        }
        EOS
      }

      it 'should detect a single problem' do
        expect(problems).to have(2).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(3).in_column(32)
        expect(problems).to contain_warning(msg).on_line(8).in_column(27)
      end
    end
  end
end
