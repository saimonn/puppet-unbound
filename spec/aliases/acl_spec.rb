require 'spec_helper'

if Puppet::Util::Package.versioncmp(Puppet.version, '4.4.0') >= 0
  describe 'test::acl', type: :class do
    describe 'accepts ACLs' do
      [
        ['127.0.0.1', 'allow'],
        ['::1', 'allow_snoop'],
        ['192.0.2.1', 'deny'],
        ['2001:db8::1', 'deny_non_local'],
        ['192.0.2.0/24', 'refuse'],
        ['2001:db8::/32', 'refuse_non_local'],
      ].each do |value|
        describe value.inspect do
          let(:params) {{ value: value }}
          it { is_expected.to compile }
        end
      end
    end
    describe 'rejects other values' do
      [
        1,
        ['invalid', 'allow'],
        ['127.0.0.1', 'invalid'],
      ].each do |value|
        describe value.inspect do
          let(:params) {{ value: value }}
          it { is_expected.to compile.and_raise_error(/parameter 'value' /) }
        end
      end
    end
  end
end
