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
      }

      ::unbound::stub { 'example.com.':
        addr => [
          $::ipaddress,
        ],
      }

      ::unbound::local { 'example.org.':
        type => 'static',
        data => [
          'example.org. 86400 IN NS ns1.example.org.',
          'example.org. 86400 IN SOA ns1.example.org. hostmaster.example.org. 1 10800 15 604800 10800',
          'ns1.example.org. 86400 IN A 192.168.1.1',
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

  describe package('unbound'), :if => fact('osfamily') != 'OpenBSD' do
    it { should be_installed }
  end

  describe file('/etc/sysconfig/unbound'), :if => fact('osfamily') == 'RedHat' do
    it { should_not exist }
  end

  describe file(conf_dir), :if => fact('osfamily') == 'OpenBSD' do
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
    its(:stdout) { should match /version:\s+\d+\.\d+\.\d+/ }
    its(:stdout) { should match /verbosity:\s+1/ }
    its(:stdout) { should match /threads:\s+1/ }
    its(:stdout) { should match /modules:\s+2\s+\[\s+validator\s+iterator\s+\]/ }
    its(:stdout) { should match /uptime:\s+\d+\s+seconds?/ }
    its(:stdout) { should match /unbound\s+\(pid\s+\d+\)\s+is\s+running\.\.\./ }
  end

  describe command('dig @127.0.0.1 version.server txt chaos +time=1 +tries=1') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /version\.server\.\s+0\s+CH\s+TXT\s+"unbound\s+\d+\.\d+\.\d+"/ }
  end

  describe command('dig @127.0.0.1 com soa +dnssec +time=1 +tries=1') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /opcode:\s+QUERY,\s+status:\s+NOERROR/ }
    its(:stdout) { should match /;;\s+flags:\s+qr\s+rd\s+ra\s+ad;/ }
  end

  describe command('dig @127.0.0.1 example.com soa +time=1 +tries=1') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /example\.com\.\s+86400\s+IN\s+SOA\s+ns1\.example\.com\.\s+hostmaster\.example\.com\.\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+/ }
  end

  describe command('dig @127.0.0.1 example.org soa +time=1 +tries=1') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /example\.org\.\s+86400\s+IN\s+SOA\s+ns1\.example\.org\.\s+hostmaster\.example\.org\.\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+/ }
  end
end
