# Installs and configures Unbound.
#
# @example Configure Unbound listening on all interfaces
#   include ::unbound
#
# @example Update the above example to specify the forwarders to use and allow access from the local network
#   class { '::unbound':
#     access_control => [
#       ["${::network}/${netmask_to_masklen($::netmask)}", 'allow'],
#       ["${::network6}/${netmask_to_masklen($::netmask6)}", 'allow'],
#     ],
#   }
#
#   ::unbound::forward { '.':
#     forward_addr => [
#       '8.8.8.8',
#       '8.8.4.4',
#       '2001:4860:4860::8844',
#       '2001:4860:4860::8888',
#     ],
#   }
#
# @param conf_dir
# @param enable_dns64
# @param enable_dnssec
# @param enable_ecs
# @param enable_ipsec
# @param group
# @param manage_control
# @param manage_package
# @param package_name
# @param service_name
# @param access_control
# @param access_control_tag
# @param access_control_tag_action
# @param access_control_tag_data
# @param access_control_view
# @param add_holddown
# @param auto_trust_anchor_file
# @param cache_max_negative_ttl
# @param cache_max_ttl
# @param cache_min_ttl
# @param caps_whitelist
# @param chroot
# @param client_subnet_always_forward
# @param client_subnet_zone
# @param control_cert_file
# @param control_enable
# @param control_interface
# @param control_key_file
# @param control_port
# @param control_use_cert
# @param define_tag
# @param del_holddown
# @param delay_close
# @param directory
# @param disable_dnssec_lame_check
# @param dns64_prefix
# @param dns64_synthall
# @param dnscrypt_enable
# @param dnscrypt_port
# @param dnscrypt_provider
# @param dnscrypt_provider_cert
# @param dnscrypt_secret_key
# @param do_daemonize
# @param do_ip4
# @param do_ip6
# @param do_not_query_address
# @param do_not_query_localhost
# @param do_tcp
# @param do_udp
# @param domain_insecure
# @param edns_buffer_size
# @param extended_statistics
# @param harden_algo_downgrade
# @param harden_below_nxdomain
# @param harden_dnssec_stripped
# @param harden_glue
# @param harden_large_queries
# @param harden_referral_path
# @param harden_short_bufsize
# @param hide_identity
# @param hide_trustanchor
# @param hide_version
# @param identity
# @param ignore_cd_flag
# @param incoming_num_tcp
# @param infra_host_ttl
# @param infra_cache_min_rtt
# @param infra_cache_numhosts
# @param infra_cache_slabs
# @param insecure_lan_zones
# @param interface
# @param interface_automatic
# @param ip_freebind
# @param ip_ratelimit
# @param ip_ratelimit_factor
# @param ip_ratelimit_size
# @param ip_ratelimit_slabs
# @param ip_transparent
# @param ipsecmod_enabled
# @param ipsecmod_hook
# @param ipsecmod_ignore_bogus
# @param ipsecmod_max_ttl
# @param ipsecmod_strict
# @param ipsecmod_whitelist
# @param jostle_timeout
# @param keep_missing
# @param key_cache_size
# @param key_cache_slabs
# @param local_data
# @param local_data_ptr
# @param local_zone
# @param local_zone_override
# @param local_zone_tag
# @param log_identity
# @param log_queries
# @param log_replies
# @param log_time_ascii
# @param logfile
# @param max_client_subnet_ipv4
# @param max_client_subnet_ipv6
# @param max_udp_size
# @param minimal_responses
# @param msg_buffer_size
# @param msg_cache_size
# @param msg_cache_slabs
# @param neg_cache_size
# @param num_queries_per_thread
# @param num_threads
# @param outgoing_interface
# @param outgoing_num_tcp
# @param outgoing_port
# @param outgoing_range
# @param outgoing_tcp_mss
# @param permit_small_holddown
# @param pidfile
# @param port
# @param prefer_ip6
# @param prefetch
# @param prefetch_key
# @param private_address
# @param private_domain
# @param qname_minimisation
# @param qname_minimisation_strict
# @param ratelimit
# @param ratelimit_below_domain
# @param ratelimit_factor
# @param ratelimit_for_domain
# @param ratelimit_size
# @param ratelimit_slabs
# @param root_hints
# @param rrset_cache_size
# @param rrset_cache_slabs
# @param rrset_roundrobin
# @param send_client_subnet
# @param serve_expired
# @param server_cert_file
# @param server_key_file
# @param so_rcvbuf
# @param so_reuseport
# @param so_sndbuf
# @param ssl_port
# @param ssl_service_key
# @param ssl_service_pem
# @param ssl_upstream
# @param statistics_cumulative
# @param statistics_interval
# @param target_fetch_policy
# @param tcp_mss
# @param tcp_upstream
# @param trust_anchor
# @param trust_anchor_file
# @param trust_anchor_signaling
# @param unblock_lan_zones
# @param unwanted_reply_threshold
# @param use_caps_for_id
# @param use_syslog
# @param use_systemd
# @param username
# @param val_bogus_ttl
# @param val_clean_additional
# @param val_log_level
# @param val_nsec3_keysize_iterations
# @param val_override_date
# @param val_permissive_mode
# @param val_sig_skew_max
# @param val_sig_skew_min
# @param verbosity
# @param version
#
# @see puppet_defined_types::unbound::forward
# @see puppet_defined_types::unbound::stub
# @see puppet_defined_types::unbound::view
class unbound (
  Stdlib::Absolutepath                                                            $conf_dir                     = $::unbound::params::conf_dir,
  Boolean                                                                         $enable_dns64                 = false,
  Boolean                                                                         $enable_dnssec                = true,
  Boolean                                                                         $enable_ecs                   = false,
  Boolean                                                                         $enable_ipsec                 = false,
  String                                                                          $group                        = $::unbound::params::group,
  Boolean                                                                         $manage_control               = true,
  Boolean                                                                         $manage_package               = $::unbound::params::manage_package,
  Optional[String]                                                                $package_name                 = $::unbound::params::package_name,
  String                                                                          $service_name                 = 'unbound',
  # Below map to global configuration parameters
  Optional[Array[Tuple[IP::Address, Unbound::ACL::Action], 1]]                    $access_control               = undef,
  Optional[Array[Tuple[IP::Address, Array[String, 1]], 1]]                        $access_control_tag           = undef,
  Optional[Array[Tuple[IP::Address, String, Unbound::ACL::Action], 1]]            $access_control_tag_action    = undef,
  Optional[Array[Tuple[IP::Address, String, Unbound::Record], 1]]                 $access_control_tag_data      = undef,
  Optional[Array[Tuple[IP::Address, String], 1]]                                  $access_control_view          = undef,
  Optional[Integer[0]]                                                            $add_holddown                 = undef,
  Optional[Stdlib::Absolutepath]                                                  $auto_trust_anchor_file       = $::unbound::params::auto_trust_anchor_file,
  Optional[Integer[0]]                                                            $cache_max_negative_ttl       = undef,
  Optional[Integer[0]]                                                            $cache_max_ttl                = undef,
  Optional[Integer[0]]                                                            $cache_min_ttl                = undef,
  Optional[Array[Bodgitlib::Zone::NonRoot, 1]]                                    $caps_whitelist               = undef,
  Optional[Stdlib::Absolutepath]                                                  $chroot                       = $::unbound::params::chroot,
  Optional[Boolean]                                                               $client_subnet_always_forward = undef,
  Optional[Array[Bodgitlib::Zone::NonRoot, 1]]                                    $client_subnet_zone           = undef,
  Optional[Stdlib::Absolutepath]                                                  $control_cert_file            = $::unbound::params::control_cert_file,
  Optional[Boolean]                                                               $control_enable               = true,
  Optional[Array[Variant[IP::Address::NoSubnet, Stdlib::Absolutepath], 1]]        $control_interface            = undef,
  Optional[Stdlib::Absolutepath]                                                  $control_key_file             = $::unbound::params::control_key_file,
  Optional[Bodgitlib::Port]                                                       $control_port                 = undef,
  Optional[Boolean]                                                               $control_use_cert             = undef,
  Optional[Array[String, 1]]                                                      $define_tag                   = undef,
  Optional[Integer[0]]                                                            $del_holddown                 = undef,
  Optional[Integer[0]]                                                            $delay_close                  = undef,
  Optional[Stdlib::Absolutepath]                                                  $directory                    = undef,
  Optional[Boolean]                                                               $disable_dnssec_lame_check    = undef,
  Optional[IP::Address::V6]                                                       $dns64_prefix                 = undef,
  Optional[Boolean]                                                               $dns64_synthall               = undef,
  Optional[Boolean]                                                               $dnscrypt_enable              = undef,
  Optional[Bodgitlib::Port]                                                       $dnscrypt_port                = undef,
  Optional[Bodgitlib::Zone::NonRoot]                                              $dnscrypt_provider            = undef,
  Optional[Array[Stdlib::Absolutepath, 1]]                                        $dnscrypt_provider_cert       = undef,
  Optional[Array[Stdlib::Absolutepath, 1]]                                        $dnscrypt_secret_key          = undef,
  Optional[Boolean]                                                               $do_daemonize                 = undef,
  Optional[Boolean]                                                               $do_ip4                       = undef,
  Optional[Boolean]                                                               $do_ip6                       = undef,
  Optional[Array[IP::Address, 1]]                                                 $do_not_query_address         = undef,
  Optional[Boolean]                                                               $do_not_query_localhost       = undef,
  Optional[Boolean]                                                               $do_tcp                       = undef,
  Optional[Boolean]                                                               $do_udp                       = undef,
  Optional[Array[Bodgitlib::Zone::NonRoot, 1]]                                    $domain_insecure              = undef,
  Optional[Integer[0]]                                                            $edns_buffer_size             = undef,
  Optional[Boolean]                                                               $extended_statistics          = undef,
  Optional[Boolean]                                                               $harden_algo_downgrade        = undef,
  Optional[Boolean]                                                               $harden_below_nxdomain        = undef,
  Optional[Boolean]                                                               $harden_dnssec_stripped       = undef,
  Optional[Boolean]                                                               $harden_glue                  = undef,
  Optional[Boolean]                                                               $harden_large_queries         = undef,
  Optional[Boolean]                                                               $harden_referral_path         = undef,
  Optional[Boolean]                                                               $harden_short_bufsize         = undef,
  Optional[Boolean]                                                               $hide_identity                = undef,
  Optional[Boolean]                                                               $hide_trustanchor             = undef,
  Optional[Boolean]                                                               $hide_version                 = undef,
  Optional[String]                                                                $identity                     = undef,
  Optional[Boolean]                                                               $ignore_cd_flag               = undef,
  Optional[Integer[0]]                                                            $incoming_num_tcp             = undef,
  Optional[Integer[0]]                                                            $infra_host_ttl               = undef,
  Optional[Integer[0]]                                                            $infra_cache_min_rtt          = undef,
  Optional[Integer[0]]                                                            $infra_cache_numhosts         = undef,
  Optional[Integer[1]]                                                            $infra_cache_slabs            = undef,
  Optional[Boolean]                                                               $insecure_lan_zones           = undef,
  Optional[Array[Unbound::Interface::Incoming, 1]]                                $interface                    = undef,
  Optional[Boolean]                                                               $interface_automatic          = undef,
  Optional[Boolean]                                                               $ip_freebind                  = undef,
  Optional[Integer[0]]                                                            $ip_ratelimit                 = undef,
  Optional[Integer[0]]                                                            $ip_ratelimit_factor          = undef,
  Optional[Unbound::Size]                                                         $ip_ratelimit_size            = undef,
  Optional[Integer[1]]                                                            $ip_ratelimit_slabs           = undef,
  Optional[Boolean]                                                               $ip_transparent               = undef,
  Optional[Boolean]                                                               $ipsecmod_enabled             = undef,
  Optional[Stdlib::Absolutepath]                                                  $ipsecmod_hook                = undef,
  Optional[Boolean]                                                               $ipsecmod_ignore_bogus        = undef,
  Optional[Integer[0]]                                                            $ipsecmod_max_ttl             = undef,
  Optional[Boolean]                                                               $ipsecmod_strict              = undef,
  Optional[Array[Bodgitlib::Zone::NonRoot, 1]]                                    $ipsecmod_whitelist           = undef,
  Optional[Integer[0]]                                                            $jostle_timeout               = undef,
  Optional[Integer[0]]                                                            $keep_missing                 = undef,
  Optional[Unbound::Size]                                                         $key_cache_size               = undef,
  Optional[Integer[1]]                                                            $key_cache_slabs              = undef,
  Optional[Array[Unbound::Record, 1]]                                             $local_data                   = undef,
  Optional[Array[Unbound::Record::PTR, 1]]                                        $local_data_ptr               = undef,
  Optional[Array[Tuple[Bodgitlib::Zone::NonRoot, Unbound::Type], 1]]              $local_zone                   = undef,
  Optional[Array[Tuple[Bodgitlib::Zone::NonRoot, IP::Address, Unbound::Type], 1]] $local_zone_override          = undef,
  Optional[Array[Tuple[Bodgitlib::Zone::NonRoot, Array[String, 1]], 1]]           $local_zone_tag               = undef,
  Optional[String]                                                                $log_identity                 = undef,
  Optional[Boolean]                                                               $log_queries                  = undef,
  Optional[Boolean]                                                               $log_replies                  = undef,
  Optional[Boolean]                                                               $log_time_ascii               = undef,
  Optional[Stdlib::Absolutepath]                                                  $logfile                      = undef,
  Optional[Integer[0, 32]]                                                        $max_client_subnet_ipv4       = undef,
  Optional[Integer[0, 128]]                                                       $max_client_subnet_ipv6       = undef,
  Optional[Integer[0, 65536]]                                                     $max_udp_size                 = undef,
  Optional[Boolean]                                                               $minimal_responses            = undef,
  Optional[Integer[0, 65552]]                                                     $msg_buffer_size              = undef,
  Optional[Unbound::Size]                                                         $msg_cache_size               = undef,
  Optional[Integer[1]]                                                            $msg_cache_slabs              = undef,
  Optional[Unbound::Size]                                                         $neg_cache_size               = undef,
  Optional[Integer[0]]                                                            $num_queries_per_thread       = undef,
  Optional[Integer[1]]                                                            $num_threads                  = undef,
  Optional[Array[Unbound::Interface::Outgoing, 1]]                                $outgoing_interface           = undef,
  Optional[Integer[0]]                                                            $outgoing_num_tcp             = undef,
  Optional[Array[Unbound::Port, 1]]                                               $outgoing_port                = undef,
  Optional[Integer[1, 65535]]                                                     $outgoing_range               = undef,
  Optional[Integer[0]]                                                            $outgoing_tcp_mss             = undef,
  Optional[Boolean]                                                               $permit_small_holddown        = undef,
  Optional[Stdlib::Absolutepath]                                                  $pidfile                      = undef,
  Optional[Bodgitlib::Port]                                                       $port                         = undef,
  Optional[Boolean]                                                               $prefer_ip6                   = undef,
  Optional[Boolean]                                                               $prefetch                     = undef,
  Optional[Boolean]                                                               $prefetch_key                 = undef,
  Optional[Array[IP::Address, 1]]                                                 $private_address              = undef,
  Optional[Array[Bodgitlib::Zone::NonRoot, 1]]                                    $private_domain               = undef,
  Optional[Boolean]                                                               $qname_minimisation           = undef,
  Optional[Boolean]                                                               $qname_minimisation_strict    = undef,
  Optional[Integer[0]]                                                            $ratelimit                    = undef,
  Optional[Array[Unbound::RateLimit, 1]]                                          $ratelimit_below_domain       = undef,
  Optional[Integer[0]]                                                            $ratelimit_factor             = undef,
  Optional[Array[Unbound::RateLimit, 1]]                                          $ratelimit_for_domain         = undef,
  Optional[Unbound::Size]                                                         $ratelimit_size               = undef,
  Optional[Integer[1]]                                                            $ratelimit_slabs              = undef,
  Optional[Stdlib::Absolutepath]                                                  $root_hints                   = undef,
  Optional[Unbound::Size]                                                         $rrset_cache_size             = undef,
  Optional[Integer[1]]                                                            $rrset_cache_slabs            = undef,
  Optional[Boolean]                                                               $rrset_roundrobin             = undef,
  Optional[Array[IP::Address, 1]]                                                 $send_client_subnet           = undef,
  Optional[Boolean]                                                               $serve_expired                = undef,
  Optional[Stdlib::Absolutepath]                                                  $server_cert_file             = $::unbound::params::server_cert_file,
  Optional[Stdlib::Absolutepath]                                                  $server_key_file              = $::unbound::params::server_key_file,
  Optional[Unbound::Size]                                                         $so_rcvbuf                    = undef,
  Optional[Boolean]                                                               $so_reuseport                 = undef,
  Optional[Unbound::Size]                                                         $so_sndbuf                    = undef,
  Optional[Bodgitlib::Port]                                                       $ssl_port                     = undef,
  Optional[Stdlib::Absolutepath]                                                  $ssl_service_key              = undef,
  Optional[Stdlib::Absolutepath]                                                  $ssl_service_pem              = undef,
  Optional[Boolean]                                                               $ssl_upstream                 = undef,
  Optional[Boolean]                                                               $statistics_cumulative        = undef,
  Optional[Integer[0]]                                                            $statistics_interval          = undef,
  Optional[Tuple[Integer[-1], 5]]                                                 $target_fetch_policy          = undef,
  Optional[Integer[0]]                                                            $tcp_mss                      = undef,
  Optional[Boolean]                                                               $tcp_upstream                 = undef,
  Optional[Array[String, 1]]                                                      $trust_anchor                 = undef,
  Optional[Stdlib::Absolutepath]                                                  $trust_anchor_file            = undef,
  Optional[Boolean]                                                               $trust_anchor_signaling       = undef,
  Optional[Boolean]                                                               $unblock_lan_zones            = undef,
  Optional[Integer[0]]                                                            $unwanted_reply_threshold     = undef,
  Optional[Boolean]                                                               $use_caps_for_id              = undef,
  Optional[Boolean]                                                               $use_syslog                   = undef,
  Optional[Boolean]                                                               $use_systemd                  = undef,
  Optional[String]                                                                $username                     = $::unbound::params::username,
  Optional[Integer[0]]                                                            $val_bogus_ttl                = undef,
  Optional[Boolean]                                                               $val_clean_additional         = undef,
  Optional[Integer[0, 2]]                                                         $val_log_level                = undef,
  Optional[Array[Tuple[Integer[0], 2], 1]]                                        $val_nsec3_keysize_iterations = undef,
  Optional[String]                                                                $val_override_date            = undef,
  Optional[Boolean]                                                               $val_permissive_mode          = undef,
  Optional[Integer[0]]                                                            $val_sig_skew_max             = undef,
  Optional[Integer[0]]                                                            $val_sig_skew_min             = undef,
  Optional[Integer[0, 5]]                                                         $verbosity                    = undef,
  Optional[String]                                                                $version                      = undef,
) inherits ::unbound::params {

  if $manage_control and ($control_cert_file != $::unbound::params::control_cert_file or $control_key_file != $::unbound::params::control_key_file or $server_cert_file != $::unbound::params::server_cert_file or $server_key_file != $::unbound::params::server_key_file) {
    fail('Cannot have $manage_control enabled with non-standard locations for remote control keys and/or certificates')
  }

  contain ::unbound::install
  contain ::unbound::config
  contain ::unbound::service

  Class['::unbound::install'] ~> Class['::unbound::config']
    ~> Class['::unbound::service']
}
