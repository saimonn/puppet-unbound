require 'spec_helper'

if Puppet::Util::Package.versioncmp(Puppet.version, '4.4.0') >= 0
  describe 'test::record', type: :class do
    describe 'accepts records' do
      [
        {
          'name'  => 'www.example.com.',
          'type'  => 'A',
          'ip'    => '192.0.2.1',
          'class' => 'IN',
        },
        {
          'name' => 'www.example.com.',
          'type' => 'AAAA',
          'ip'   => '2001:db8::1',
          'ttl'  => 3600,
        },
        {
          'name'     => 'example.com.',
          'type'     => 'MX',
          'priority' => 10,
          'hostname' => 'mail.example.com.',
        },
        {
          'name'     => 'example.com.',
          'type'     => 'NS',
          'hostname' => 'ns.example.com.',
          'class'    => 'IN',
          'ttl'      => 86400,
        },
        {
          'name'     => '1.2.0.192.in-addr.arpa.',
          'type'     => 'PTR',
          'hostname' => 'www.example.com.',
        },
        {
          'name'     => 'example.com.',
          'type'     => 'SOA',
          'primary'  => 'ns.example.com.',
          'email'    => 'hostmaster.example.com.',
          'serial'   => 1,
          'refresh'  => 3600,
          'retry'    => 1200,
          'expire'   => 604800,
          'negative' => 10800,
        },
        {
          'name'  => 'example.com.',
          'type'  => 'TXT',
          'value' => 'example',
          'class' => 'IN',
          'ttl'   => 3600,
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
          'name' => 'www.example.com.',
          'type' => 'A',
          'ip'   => 'invalid',
        },
        {
          'name' => 'www.example.com',
          'type' => 'A',
          'ip'   => '192.0.2.1',
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
