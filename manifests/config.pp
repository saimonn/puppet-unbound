#
class unbound::config {

  $access_control               = $::unbound::access_control
  $add_holddown                 = $::unbound::add_holddown
  $auto_trust_anchor_file       = $::unbound::auto_trust_anchor_file
  $cache_max_negative_ttl       = $::unbound::cache_max_negative_ttl
  $cache_max_ttl                = $::unbound::cache_max_ttl
  $cache_min_ttl                = $::unbound::cache_min_ttl
  $caps_whitelist               = $::unbound::caps_whitelist
  $chroot                       = $::unbound::chroot
  $conf_dir                     = $::unbound::conf_dir
  $control_cert_file            = $::unbound::control_cert_file
  $control_enable               = $::unbound::control_enable
  $control_interface            = $::unbound::control_interface
  $control_key_file             = $::unbound::control_key_file
  $control_port                 = $::unbound::control_port
  $control_use_cert             = $::unbound::control_use_cert
  $del_holddown                 = $::unbound::del_holddown
  $delay_close                  = $::unbound::delay_close
  $directory                    = $::unbound::directory
  $disable_dnssec_lame_check    = $::unbound::disable_dnssec_lame_check
  $do_ip4                       = $::unbound::do_ip4
  $do_ip6                       = $::unbound::do_ip6
  $do_not_query_address         = $::unbound::do_not_query_address
  $do_not_query_localhost       = $::unbound::do_not_query_localhost
  $do_tcp                       = $::unbound::do_tcp
  $do_udp                       = $::unbound::do_udp
  $domain_insecure              = $::unbound::domain_insecure
  $dns64_prefix                 = $::unbound::dns64_prefix
  $dns64_synthall               = $::unbound::dns64_synthall
  $edns_buffer_size             = $::unbound::edns_buffer_size
  $extended_statistics          = $::unbound::extended_statistics
  $group                        = $::unbound::group
  $harden_algo_downgrade        = $::unbound::harden_algo_downgrade
  $harden_below_nxdomain        = $::unbound::harden_below_nxdomain
  $harden_dnssec_stripped       = $::unbound::harden_dnssec_stripped
  $harden_glue                  = $::unbound::harden_glue
  $harden_large_queries         = $::unbound::harden_large_queries
  $harden_referral_path         = $::unbound::harden_referral_path
  $harden_short_bufsize         = $::unbound::harden_short_bufsize
  $hide_identity                = $::unbound::hide_identity
  $hide_version                 = $::unbound::hide_version
  $identity                     = $::unbound::identity
  $ignore_cd_flag               = $::unbound::ignore_cd_flag
  $incoming_num_tcp             = $::unbound::incoming_num_tcp
  $infra_host_ttl               = $::unbound::infra_host_ttl
  $infra_cache_min_rtt          = $::unbound::infra_cache_min_rtt
  $infra_cache_numhosts         = $::unbound::infra_cache_numhosts
  $infra_cache_slabs            = $::unbound::infra_cache_slabs
  $insecure_lan_zones           = $::unbound::insecure_lan_zones
  $interface                    = $::unbound::interface
  $interface_automatic          = $::unbound::interface_automatic
  $ip_freebind                  = $::unbound::ip_freebind
  $ip_transparent               = $::unbound::ip_transparent
  $jostle_timeout               = $::unbound::jostle_timeout
  $keep_missing                 = $::unbound::keep_missing
  $key_cache_size               = $::unbound::key_cache_size
  $key_cache_slabs              = $::unbound::key_cache_slabs
  $log_queries                  = $::unbound::log_queries
  $log_time_ascii               = $::unbound::log_time_ascii
  $logfile                      = $::unbound::logfile
  $max_udp_size                 = $::unbound::max_udp_size
  $minimal_responses            = $::unbound::minimal_responses
  $msg_buffer_size              = $::unbound::msg_buffer_size
  $msg_cache_size               = $::unbound::msg_cache_size
  $msg_cache_slabs              = $::unbound::msg_cache_slabs
  $neg_cache_size               = $::unbound::neg_cache_size
  $num_queries_per_thread       = $::unbound::num_queries_per_thread
  $num_threads                  = $::unbound::num_threads
  $outgoing_interface           = $::unbound::outgoing_interface
  $outgoing_num_tcp             = $::unbound::outgoing_num_tcp
  $outgoing_port                = $::unbound::outgoing_port
  $outgoing_range               = $::unbound::outgoing_range
  $outgoing_tcp_mss             = $::unbound::outgoing_tcp_mss
  $permit_small_holddown        = $::unbound::permit_small_holddown
  $pidfile                      = $::unbound::pidfile
  $port                         = $::unbound::port
  $prefetch                     = $::unbound::prefetch
  $prefetch_key                 = $::unbound::prefetch_key
  $private_address              = $::unbound::private_address
  $private_domain               = $::unbound::private_domain
  $qname_minimisation           = $::unbound::qname_minimisation
  $ratelimit                    = $::unbound::ratelimit
  $ratelimit_below_domain       = $::unbound::ratelimit_below_domain
  $ratelimit_factor             = $::unbound::ratelimit_factor
  $ratelimit_for_domain         = $::unbound::ratelimit_for_domain
  $ratelimit_size               = $::unbound::ratelimit_size
  $ratelimit_slabs              = $::unbound::ratelimit_slabs
  $root_hints                   = $::unbound::root_hints
  $rrset_cache_size             = $::unbound::rrset_cache_size
  $rrset_cache_slabs            = $::unbound::rrset_cache_slabs
  $rrset_roundrobin             = $::unbound::rrset_roundrobin
  $server_cert_file             = $::unbound::server_cert_file
  $server_key_file              = $::unbound::server_key_file
  $so_rcvbuf                    = $::unbound::so_rcvbuf
  $so_reuseport                 = $::unbound::so_reuseport
  $so_sndbuf                    = $::unbound::so_sndbuf
  $ssl_port                     = $::unbound::ssl_port
  $ssl_service_key              = $::unbound::ssl_service_key
  $ssl_service_pem              = $::unbound::ssl_service_pem
  $ssl_upstream                 = $::unbound::ssl_upstream
  $statistics_cumulative        = $::unbound::statistics_cumulative
  $statistics_interval          = $::unbound::statistics_interval
  $target_fetch_policy          = $::unbound::target_fetch_policy
  $tcp_mss                      = $::unbound::tcp_mss
  $tcp_upstream                 = $::unbound::tcp_upstream
  $trust_anchor                 = $::unbound::trust_anchor
  $trust_anchor_file            = $::unbound::trust_anchor_file
  $unblock_lan_zones            = $::unbound::unblock_lan_zones
  $unwanted_reply_threshold     = $::unbound::unwanted_reply_threshold
  $use_caps_for_id              = $::unbound::use_caps_for_id
  $use_syslog                   = $::unbound::use_syslog
  $username                     = $::unbound::username
  $val_bogus_ttl                = $::unbound::val_bogus_ttl
  $val_clean_additional         = $::unbound::val_clean_additional
  $val_log_level                = $::unbound::val_log_level
  $val_nsec3_keysize_iterations = $::unbound::val_nsec3_keysize_iterations
  $val_override_date            = $::unbound::val_override_date
  $val_permissive_mode          = $::unbound::val_permissive_mode
  $val_sig_skew_max             = $::unbound::val_sig_skew_max
  $val_sig_skew_min             = $::unbound::val_sig_skew_min
  $verbosity                    = $::unbound::verbosity
  $version                      = $::unbound::version

  $module_config = delete_undef_values([
    $::unbound::enable_dns64 ? {
      true    => 'dns64',
      default => undef,
    },
    $::unbound::enable_dnssec ? {
      true    => 'validator',
      default => undef,
    },
    'iterator',
  ])

  case $::osfamily { # lint:ignore:case_without_default
    'RedHat': {
      file { '/etc/sysconfig/unbound':
        ensure => absent,
      }

      # At least on RHEL 6 the PID directory isn't created by the package so
      # it will cause `unbound-checkconf` to fail before unbound has ever been
      # started
      file { '/var/run/unbound':
        ensure => directory,
        owner  => $username,
        group  => $group,
        mode   => '0644',
      }

      # RHEL 7 installs an unbound-anchor service which keeps the root anchor
      # updated and runs as the unbound user however it runs the same command
      # as root as an ExecStartPre step in the main unbound service which
      # screws up the file ownership so patch the unit not to do that
      case $::operatingsystemmajrelease { # lint:ignore:case_without_default
        '7': {
          file { '/etc/systemd/system/unbound.service.d':
            ensure => directory,
            owner  => 0,
            group  => 0,
            mode   => '0644',
          }

          ensure_resource('exec', 'systemctl daemon-reload', {
            refreshonly => true,
            path        => $::path,
          })

          file { '/etc/systemd/system/unbound.service.d/override.conf':
            ensure  => file,
            owner   => 0,
            group   => 0,
            mode    => '0644',
            content => file('unbound/override.conf'),
            notify  => Exec['systemctl daemon-reload'],
          }
        }
      }
    }
    'OpenBSD': {
      # And OpenBSD does something similar in its rc.d(8) script
      file { '/etc/rc.d/unbound':
        ensure  => file,
        owner   => 0,
        group   => 0,
        mode    => '0555',
        content => file('unbound/unbound'),
      }
    }
  }

  file { $conf_dir:
    ensure       => directory,
    owner        => 0,
    group        => 0,
    mode         => '0644',
    force        => true,
    purge        => true,
    recurse      => true,
    recurselimit => 1,
  }

  file { "${conf_dir}/keys.d":
    ensure       => directory,
    owner        => 0,
    group        => $group,
    mode         => '0644',
    force        => true,
    purge        => true,
    recurse      => true,
    recurselimit => 1,
  }

  ::concat { "${conf_dir}/unbound.conf":
    owner        => 0,
    group        => 0,
    mode         => '0644',
    warn         => "# !!! Managed by Puppet !!!\n\n",
    validate_cmd => '/usr/sbin/unbound-checkconf %',
  }

  if $auto_trust_anchor_file {
    file { "${conf_dir}/icannbundle.pem":
      ensure  => file,
      owner   => 0,
      group   => 0,
      mode    => '0644',
      content => file('unbound/icannbundle.pem'),
    }

    $exec = "/usr/sbin/unbound-anchor -a ${auto_trust_anchor_file} -c ${conf_dir}/icannbundle.pem"

    exec { $exec:
      creates => $auto_trust_anchor_file,
      returns => [0, 1],
      require => File["${conf_dir}/icannbundle.pem"],
    }

    file { $auto_trust_anchor_file:
      ensure  => file,
      owner   => $username,
      group   => $group,
      mode    => '0644',
      require => Exec[$exec],
      before  => ::Concat["${conf_dir}/unbound.conf"],
    }
  }

  ::concat::fragment { 'unbound server':
    content => template('unbound/server.erb'),
    order   => '01',
    target  => "${conf_dir}/unbound.conf",
  }

  ::concat::fragment { 'unbound control':
    content => template('unbound/control.erb'),
    order   => '20',
    target  => "${conf_dir}/unbound.conf",
  }

  if $::unbound::manage_control {
    $control_files = [
      $control_cert_file,
      $control_key_file,
      $server_cert_file,
      $server_key_file,
    ]

    exec { 'unbound-control-setup':
      path    => $::path,
      creates => $control_files,
    }

    file { $control_files:
      ensure  => file,
      owner   => 0,
      group   => $group,
      mode    => '0640',
      require => Exec['unbound-control-setup'],
      before  => ::Concat["${conf_dir}/unbound.conf"],
    }
  }
}
