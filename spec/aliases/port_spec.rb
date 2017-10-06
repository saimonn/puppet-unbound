require 'spec_helper'

if Puppet::Util::Package.versioncmp(Puppet.version, '4.4.0') >= 0
  describe 'test::port', type: :class do
    describe 'accepts ports' do
      [
        ['permit', 1024],
        ['permit', 1024, 65535],
        ['avoid', 1024],
        ['avoid', 1024, 65535],
      ].each do |value|
        describe value.inspect do
          let(:params) {{ value: value }}
          it { is_expected.to compile }
        end
      end
    end
    describe 'rejects other values' do
      [
        ['invalid', 65536],
        ['invalid', 1024, 65536],
      ].each do |value|
        describe value.inspect do
          let(:params) {{ value: value }}
          it { is_expected.to compile.and_raise_error(/parameter 'value' /) }
        end
      end
    end
  end
end
