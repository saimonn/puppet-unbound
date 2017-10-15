require 'spec_helper_acceptance'

describe 'unbound' do

  case fact('osfamily')
  when 'RedHat'
    conf_dir   = '/etc/unbound'
    group      = 'unbound'
    root_group = 'root'
    username   = 'unbound'

    case fact('operatingsystemmajrelease')
    when '6'
      root_key = '/var/lib/unbound/root.anchor'
    else
      root_key = '/var/lib/unbound/root.key'
    end
  when 'OpenBSD'
    conf_dir   = '/var/unbound/etc'
    group      = '_unbound'
    root_group = 'wheel'
    root_key   = '/var/unbound/db/root.key'
    username   = '_unbound'
  end

  it 'should work with no errors' do

    pp = <<-EOS
      class { '::nsd':
        ip_address => [
          $::ipaddress,
        ],
      }

      ::nsd::zone { 'example.com.':
        source => '/root/example.com.zone',
      }

      class { '::unbound':
        interface       => [
          '127.0.0.1',
        ],
        domain_insecure => [
          'example.com.',
        ],
        local_zone      => [
          ['example.org.', 'static'],
        ],
        local_data      => [
          {
            'name'     => 'example.org.',
            'ttl'      => 86400,
            'class'    => 'IN',
            'type'     => 'NS',
            'hostname' => 'ns1.example.org.',
          },
          {
            'name'     => 'example.org.',
            'ttl'      => 86400,
            'class'    => 'IN',
            'type'     => 'SOA',
            'primary'  => 'ns1.example.org.',
            'email'    => 'hostmaster.example.org.',
            'serial'   => 1,
            'refresh'  => 10800,
            'retry'    => 15,
            'expire'   => 604800,
            'negative' => 10800,
          },
          {
            'name'  => 'ns1.example.org.',
            'ttl'   => 86400,
            'class' => 'IN',
            'type'  => 'A',
            'ip'    => '192.168.1.1',
          },
        ],
      }

      ::unbound::stub { 'example.com.':
        stub_addr => [
          $::ipaddress,
        ],
      }

      if $::osfamily == 'RedHat' {

        package { 'bind-utils':
          ensure => present,
        }

        include ::epel
        Class['::epel'] -> Class['::nsd']
      }
    EOS

    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes  => true)
  end

  describe package('unbound'), :unless => fact('osfamily').eql?('OpenBSD') do
    it { should be_installed }
  end

  describe file('/etc/sysconfig/unbound'), :if => fact('osfamily').eql?('RedHat') do
    it { should_not exist }
  end

  describe file(conf_dir), :if => fact('osfamily').eql?('OpenBSD') do
    it { should be_directory }
    it { should be_mode 755 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into root_group }
  end

  describe file("#{conf_dir}/icannbundle.pem") do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into root_group }
  end

  describe file(root_key) do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by username }
    it { should be_grouped_into group }
  end

  describe file("#{conf_dir}/unbound.conf") do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into root_group }
  end

  %w(unbound_control.key unbound_control.pem unbound_server.key unbound_server.pem).each do |f|
    describe file("#{conf_dir}/#{f}") do
      it { should be_file }
      it { should be_mode 640 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into group }
    end
  end

  describe service('unbound') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('unbound-control status') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /version: \s+ \d+ \. \d+ \. \d+/x }
    its(:stdout) { should match /verbosity: \s+ 1/x }
    its(:stdout) { should match /threads: \s+ 1/x }
    its(:stdout) { should match /modules: \s+ 2 \s+ \[ \s+ validator \s+ iterator \s+ \]/x }
    its(:stdout) { should match /uptime: \s+ \d+ \s+ seconds?/x }
    its(:stdout) { should match /unbound \s+ \( pid \s+ \d+ \) \s+ is \s+ running \.{3}/x }
  end

  describe command('dig @127.0.0.1 version.server txt chaos +time=1 +tries=1') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /version \. server \. \s+ 0 \s+ CH \s+ TXT \s+ "unbound \s+ \d+ \. \d+ \. \d+ "/x }
  end

  describe command('dig @127.0.0.1 com soa +dnssec +time=1 +tries=1') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /opcode: \s+ QUERY , \s+ status: \s+ NOERROR/x }
    its(:stdout) { should match /;; \s+ flags: \s+ qr \s+ rd \s+ ra \s+ ad;/x }
  end

  describe command('dig @127.0.0.1 example.com soa +time=1 +tries=1') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /example \. com \. \s+ 86400 \s+ IN \s+ SOA \s+ ns1 \. example \. com \. \s+ hostmaster \. example \. com \. (?: \s+ \d+ ){5}/x }
  end

  describe command('dig @127.0.0.1 example.org soa +time=1 +tries=1') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /example \. org \. \s+ 86400 \s+ IN \s+ SOA \s+ ns1 \. example \. org \. \s+ hostmaster \. example \. org \. (?: \s+ \d+ ){5}/x }
  end
end
