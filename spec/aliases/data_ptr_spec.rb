require 'spec_helper'

if Puppet::Util::Package.versioncmp(Puppet.version, '4.4.0') >= 0
  describe 'test::data::ptr', type: :class do
    describe 'accepts PTRs' do
      [
        {
          'ip'       => '192.0.2.1',
          'hostname' => 'www.example.com.',
        },
        {
          'ip'       => '2001:db8::1',
          'hostname' => 'www.example.com.',
          'ttl'      => 3600,
        },
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
        'invalid',
        {
          'ip'       => 'invalid',
          'hostname' => 'www.example.com.',
        },
      ].each do |value|
        describe value.inspect do
          let(:params) {{ value: value }}
          it { is_expected.to compile.and_raise_error(/parameter 'value' /) }
        end
      end
    end
  end
end
