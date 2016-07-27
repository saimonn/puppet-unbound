require 'spec_helper'

describe 'unbound' do

  let(:params) do
    {
      :outgoing_port => [
        'avoid 0-32767',
        'avoid 65001-65535',
      ],
    }
  end

  context 'on unsupported distributions' do
    let(:facts) do
      {
        :osfamily => 'Unsupported'
      }
    end

    it { expect { should compile }.to raise_error(/not supported on an Unsupported/) }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}", :compile do
      let(:facts) do
        facts
      end

      it { should contain_anchor('unbound::begin') }
      it { should contain_anchor('unbound::end') }
      it { should contain_class('unbound') }
      it { should contain_class('unbound::config') }
      it { should contain_class('unbound::install') }
      it { should contain_class('unbound::params') }
      it { should contain_class('unbound::service') }
      it { should contain_concat__fragment('unbound control') }
      it { should contain_concat__fragment('unbound server') }
      it { should contain_exec('unbound-control-setup') }
      it { should contain_service('unbound') }

      case facts[:osfamily]
      when 'RedHat'
        it {
          should contain_concat('/etc/unbound/unbound.conf').with(
            'owner' => 0,
            'group' => 0,
            'mode'  => '0644',
          )
        }
        it {
          should contain_file('/etc/unbound').with(
            'owner' => 0,
            'group' => 0,
            'mode'  => '0644',
          )
        }
        it {
          should contain_file('/etc/unbound/icannbundle.pem').with(
            'owner' => 0,
            'group' => 0,
            'mode'  => '0644',
          )
        }
        it {
          should contain_file('/etc/unbound/keys.d').with(
            'owner' => 0,
            'group' => 'unbound',
            'mode'  => '0644',
          )
        }
        it {
          should contain_file('/etc/unbound/unbound_control.key').with(
            'owner' => 0,
            'group' => 'unbound',
            'mode'  => '0640',
          )
        }
        it {
          should contain_file('/etc/unbound/unbound_control.pem').with(
            'owner' => 0,
            'group' => 'unbound',
            'mode'  => '0640',
          )
        }
        it {
          should contain_file('/etc/unbound/unbound_server.key').with(
            'owner' => 0,
            'group' => 'unbound',
            'mode'  => '0640',
          )
        }
        it {
          should contain_file('/etc/unbound/unbound_server.pem').with(
            'owner' => 0,
            'group' => 'unbound',
            'mode'  => '0640',
          )
        }
        it { should contain_file('/etc/sysconfig/unbound').with_ensure('absent') }
        it {
          should contain_file('/var/run/unbound').with(
            'owner' => 'unbound',
            'group' => 'unbound',
            'mode'  => '0644',
          )
        }
        it { should contain_package('unbound') }

        case facts[:operatingsystemmajrelease]
        when '6'
          it { should contain_exec('/usr/sbin/unbound-anchor -a /var/lib/unbound/root.anchor -c /etc/unbound/icannbundle.pem') }
          it {
            should contain_file('/var/lib/unbound/root.anchor').with(
              'owner' => 'unbound',
              'group' => 'unbound',
              'mode'  => '0644',
            )
          }
        when '7'
          it { should contain_exec('systemctl daemon-reload') }
          it { should contain_exec('/usr/sbin/unbound-anchor -a /var/lib/unbound/root.key -c /etc/unbound/icannbundle.pem') }
          it { should contain_file('/etc/systemd/system/unbound.service.d') }
          it { should contain_file('/etc/systemd/system/unbound.service.d/override.conf') }
          it {
            should contain_file('/var/lib/unbound/root.key').with(
              'owner' => 'unbound',
              'group' => 'unbound',
              'mode'  => '0644',
            )
          }
        end
      when 'OpenBSD'
        it {
          should contain_concat('/var/unbound/etc/unbound.conf').with(
            'owner' => 0,
            'group' => 0,
            'mode'  => '0644',
          )
        }
        it { should contain_exec('/usr/sbin/unbound-anchor -a /var/unbound/db/root.key -c /var/unbound/etc/icannbundle.pem') }
        it { should contain_file('/etc/rc.d/unbound') }
        it {
          should contain_file('/var/unbound/db/root.key').with(
            'owner' => '_unbound',
            'group' => '_unbound',
            'mode'  => '0644',
          )
        }
        it {
          should contain_file('/var/unbound/etc').with(
            'owner' => 0,
            'group' => 0,
            'mode'  => '0644',
          )
        }
        it {
          should contain_file('/var/unbound/etc/icannbundle.pem').with(
            'owner' => 0,
            'group' => 0,
            'mode'  => '0644',
          )
        }
        it {
          should contain_file('/var/unbound/etc/keys.d').with(
            'owner' => 0,
            'group' => '_unbound',
            'mode'  => '0644',
          )
        }
        it {
          should contain_file('/var/unbound/etc/unbound_control.key').with(
            'owner' => 0,
            'group' => '_unbound',
            'mode'  => '0640',
          )
        }
        it {
          should contain_file('/var/unbound/etc/unbound_control.pem').with(
            'owner' => 0,
            'group' => '_unbound',
            'mode'  => '0640',
          )
        }
        it {
          should contain_file('/var/unbound/etc/unbound_server.key').with(
            'owner' => 0,
            'group' => '_unbound',
            'mode'  => '0640',
          )
        }
        it {
          should contain_file('/var/unbound/etc/unbound_server.pem').with(
            'owner' => 0,
            'group' => '_unbound',
            'mode'  => '0640',
          )
        }
        it { should have_package_resource_count(0) }
      end
    end
  end
end
