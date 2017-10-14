# @!visibility private
class unbound::params {

  case $::osfamily {
    'RedHat': {
      $chroot                 = undef
      $conf_dir               = '/etc/unbound'
      $group                  = 'unbound'
      $manage_package         = true
      $package_name           = 'unbound'
      $username               = 'unbound'

      case $::operatingsystemmajrelease {
        '6': {
          $auto_trust_anchor_file = '/var/lib/unbound/root.anchor'
        }
        default: {
          $auto_trust_anchor_file = '/var/lib/unbound/root.key'
        }
      }
    }
    'OpenBSD': {
      $chroot                 = '/var/unbound'
      $auto_trust_anchor_file = "${chroot}/db/root.key"
      $conf_dir               = "${chroot}/etc"
      $group                  = '_unbound'
      $manage_package         = false
      $package_name           = undef
      $username               = '_unbound'
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

  $control_cert_file = "${conf_dir}/unbound_control.pem"
  $control_key_file  = "${conf_dir}/unbound_control.key"
  $server_cert_file  = "${conf_dir}/unbound_server.pem"
  $server_key_file   = "${conf_dir}/unbound_server.key"
}
