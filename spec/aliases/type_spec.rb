require 'spec_helper'

if Puppet::Util::Package.versioncmp(Puppet.version, '4.4.0') >= 0
  describe 'test::type', type: :class do
    describe 'accepts zone types' do
      [
        'deny',
        'refuse',
        'static',
        'transparent',
        'typetransparent',
        'redirect',
        'inform',
        'inform_deny',
        'always_transparent',
        'always_refuse',
        'always_nxdomain',
        'nodefault',
      ].each do |value|
        describe value.inspect do
          let(:params) {{ value: value }}
          it { is_expected.to compile }
        end
      end
    end
    describe 'rejects other values' do
      [
        'invalid',
      ].each do |value|
        describe value.inspect do
          let(:params) {{ value: value }}
          it { is_expected.to compile.and_raise_error(/parameter 'value' /) }
        end
      end
    end
  end
end
