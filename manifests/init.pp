#
class unbound (
  $conf_dir                     = $::unbound::params::conf_dir,
  $enable_dns64                 = $::unbound::params::enable_dns64,
  $enable_dnssec                = $::unbound::params::enable_dnssec,
  $group                        = $::unbound::params::group,
  $manage_control               = $::unbound::params::manage_control,
  $manage_package               = $::unbound::params::manage_package,
  $package_name                 = $::unbound::params::package_name,
  $service_name                 = $::unbound::params::service_name,
  # Below map to global configuration parameters
  $access_control               = undef,
  $add_holddown                 = undef,
  $auto_trust_anchor_file       = $::unbound::params::auto_trust_anchor_file,
  $cache_max_negative_ttl       = undef,
  $cache_max_ttl                = undef,
  $cache_min_ttl                = undef,
  $caps_whitelist               = undef,
  $chroot                       = $::unbound::params::chroot,
  $control_cert_file            = $::unbound::params::control_cert_file,
  $control_enable               = $::unbound::params::control_enable,
  $control_interface            = undef,
  $control_key_file             = $::unbound::params::control_key_file,
  $control_port                 = undef,
  $control_use_cert             = undef,
  $del_holddown                 = undef,
  $delay_close                  = undef,
  $directory                    = undef,
  $disable_dnssec_lame_check    = undef,
  $do_ip4                       = undef,
  $do_ip6                       = undef,
  $do_not_query_address         = undef,
  $do_not_query_localhost       = undef,
  $do_tcp                       = undef,
  $do_udp                       = undef,
  $domain_insecure              = undef,
  $dns64_prefix                 = undef,
  $dns64_synthall               = undef,
  $edns_buffer_size             = undef,
  $extended_statistics          = undef,
  $harden_algo_downgrade        = undef,
  $harden_below_nxdomain        = undef,
  $harden_dnssec_stripped       = undef,
  $harden_glue                  = undef,
  $harden_large_queries         = undef,
  $harden_referral_path         = undef,
  $harden_short_bufsize         = undef,
  $hide_identity                = undef,
  $hide_version                 = undef,
  $identity                     = undef,
  $ignore_cd_flag               = undef,
  $incoming_num_tcp             = undef,
  $infra_host_ttl               = undef,
  $infra_cache_min_rtt          = undef,
  $infra_cache_numhosts         = undef,
  $infra_cache_slabs            = undef,
  $insecure_lan_zones           = undef,
  $interface                    = undef,
  $interface_automatic          = undef,
  $ip_freebind                  = undef,
  $ip_transparent               = undef,
  $jostle_timeout               = undef,
  $keep_missing                 = undef,
  $key_cache_size               = undef,
  $key_cache_slabs              = undef,
  $log_queries                  = undef,
  $log_time_ascii               = undef,
  $logfile                      = undef,
  $max_udp_size                 = undef,
  $minimal_responses            = undef,
  $msg_buffer_size              = undef,
  $msg_cache_size               = undef,
  $msg_cache_slabs              = undef,
  $neg_cache_size               = undef,
  $num_queries_per_thread       = undef,
  $num_threads                  = undef,
  $outgoing_interface           = undef,
  $outgoing_num_tcp             = undef,
  $outgoing_port                = undef,
  $outgoing_range               = undef,
  $outgoing_tcp_mss             = undef,
  $permit_small_holddown        = undef,
  $pidfile                      = undef,
  $port                         = undef,
  $prefetch                     = undef,
  $prefetch_key                 = undef,
  $private_address              = undef,
  $private_domain               = undef,
  $qname_minimisation           = undef,
  $ratelimit                    = undef,
  $ratelimit_below_domain       = undef,
  $ratelimit_factor             = undef,
  $ratelimit_for_domain         = undef,
  $ratelimit_size               = undef,
  $ratelimit_slabs              = undef,
  $root_hints                   = undef,
  $rrset_cache_size             = undef,
  $rrset_cache_slabs            = undef,
  $rrset_roundrobin             = undef,
  $server_cert_file             = $::unbound::params::server_cert_file,
  $server_key_file              = $::unbound::params::server_key_file,
  $so_rcvbuf                    = undef,
  $so_reuseport                 = undef,
  $so_sndbuf                    = undef,
  $ssl_port                     = undef,
  $ssl_service_key              = undef,
  $ssl_service_pem              = undef,
  $ssl_upstream                 = undef,
  $statistics_cumulative        = undef,
  $statistics_interval          = undef,
  $target_fetch_policy          = undef,
  $tcp_mss                      = undef,
  $tcp_upstream                 = undef,
  $trust_anchor                 = undef,
  $trust_anchor_file            = undef,
  $unblock_lan_zones            = undef,
  $unwanted_reply_threshold     = undef,
  $use_caps_for_id              = undef,
  $use_syslog                   = undef,
  $username                     = $::unbound::params::username,
  $val_bogus_ttl                = undef,
  $val_clean_additional         = undef,
  $val_log_level                = undef,
  $val_nsec3_keysize_iterations = undef,
  $val_override_date            = undef,
  $val_permissive_mode          = undef,
  $val_sig_skew_max             = undef,
  $val_sig_skew_min             = undef,
  $verbosity                    = undef,
  $version                      = undef,
) inherits ::unbound::params {

  validate_absolute_path($conf_dir)
  validate_bool($enable_dns64)
  validate_bool($enable_dnssec)
  validate_string($group)
  validate_bool($manage_control)
  validate_bool($manage_package)
  validate_string($package_name)
  validate_string($service_name)

  if $manage_control and ($control_cert_file != $::unbound::params::control_cert_file or $control_key_file != $::unbound::params::control_key_file or $server_cert_file != $::unbound::params::server_cert_file or $server_key_file != $::unbound::params::server_key_file) {
    fail('')
  }
  if $access_control {
    validate_unbound_acl($access_control, ['allow', 'allow_snoop', 'deny', 'deny_non_local', 'refuse', 'refuse_non_local'], true)
  }
  if $add_holddown {
    validate_integer($add_holddown, '', 0)
  }
  if $auto_trust_anchor_file {
    validate_absolute_path($auto_trust_anchor_file)
  }
  if $cache_max_negative_ttl {
    validate_integer($cache_max_negative_ttl, '', 0)
  }
  if $cache_max_ttl {
    validate_integer($cache_max_ttl, '', 0)
  }
  if $cache_min_ttl {
    validate_integer($cache_min_ttl, '', 0)
  }
  if $caps_whitelist {
    validate_array($caps_whitelist)
    validate_domain_name($caps_whitelist)
  }
  if $chroot and $chroot != '' {
    validate_absolute_path($chroot)
  }
  if $control_cert_file {
    validate_absolute_path($control_cert_file)
  }
  if $control_enable {
    validate_bool($control_enable)
  }
  if $control_interface {
    validate_ip_address_array($control_interface)
  }
  if $control_key_file {
    validate_absolute_path($control_key_file)
  }
  if $control_port {
    validate_integer($control_port, 65535, 0)
  }
  if $control_use_cert {
    validate_bool($control_use_cert)
  }
  if $del_holddown {
    validate_integer($del_holddown, '', 0)
  }
  if $delay_close {
    validate_integer($delay_close, '', 0)
  }
  if $directory {
    validate_absolute_path($directory)
  }
  if $disable_dnssec_lame_check {
    validate_bool($disable_dnssec_lame_check)
  }
  if $do_ip4 {
    validate_bool($do_ip4)
  }
  if $do_ip6 {
    validate_bool($do_ip6)
  }
  if $do_not_query_address {
    validate_array($do_not_query_address)
    validate_unbound_acl($do_not_query_address, [], true)
  }
  if $do_not_query_localhost {
    validate_bool($do_not_query_localhost)
  }
  if $do_tcp {
    validate_bool($do_tcp)
  }
  if $do_udp {
    validate_bool($do_udp)
  }
  if $domain_insecure {
    validate_array($domain_insecure)
    validate_domain_name($domain_insecure)
  }
  if $dns64_prefix {
    validate_string($dns64_prefix)
    validate_unbound_acl($dns64_prefix, [], true)
  }
  if $dns64_synthall {
    validate_bool($dns64_synthall)
  }
  if $edns_buffer_size {
    validate_integer($edns_buffer_size, '', 0)
  }
  if $extended_statistics {
    validate_bool($extended_statistics)
  }
  if $harden_algo_downgrade {
    validate_bool($harden_algo_downgrade)
  }
  if $harden_below_nxdomain {
    validate_bool($harden_below_nxdomain)
  }
  if $harden_dnssec_stripped {
    validate_bool($harden_dnssec_stripped)
  }
  if $harden_glue {
    validate_bool($harden_glue)
  }
  if $harden_referral_path {
    validate_bool($harden_referral_path)
  }
  if $harden_short_bufsize {
    validate_bool($harden_short_bufsize)
  }
  if $harden_large_queries {
    validate_bool($harden_large_queries)
  }
  if $hide_identity {
    validate_bool($hide_identity)
  }
  if $hide_version {
    validate_bool($hide_version)
  }
  validate_string($identity)
  if $ignore_cd_flag {
    validate_bool($ignore_cd_flag)
  }
  if $incoming_num_tcp {
    validate_integer($incoming_num_tcp, '', 0)
  }
  if $infra_host_ttl {
    validate_integer($infra_host_ttl, '', 0)
  }
  if $infra_cache_min_rtt {
    validate_integer($infra_cache_min_rtt, '', 0)
  }
  if $infra_cache_numhosts {
    validate_integer($infra_cache_numhosts, '', 0)
  }
  if $infra_cache_slabs {
    validate_integer($infra_cache_slabs, '', 1)
  }
  if $insecure_lan_zones {
    validate_bool($insecure_lan_zones)
  }
  if $interface {
    validate_unbound_acl($interface)
  }
  if $interface_automatic {
    validate_bool($interface_automatic)
  }
  if $ip_freebind {
    validate_bool($ip_freebind)
  }
  if $ip_transparent {
    validate_bool($ip_transparent)
  }
  if $jostle_timeout {
    validate_integer($jostle_timeout, '', 0)
  }
  if $keep_missing {
    validate_integer($keep_missing, '', 0)
  }
  if $key_cache_size {
    validate_re($key_cache_size, '^\d+[kmg]?$')
  }
  if $key_cache_slabs {
    validate_integer($key_cache_slabs, '', 1)
  }
  if $log_queries {
    validate_bool($log_queries)
  }
  if $log_time_ascii {
    validate_bool($log_time_ascii)
  }
  if $logfile {
    validate_absolute_path($logfile)
  }
  if $max_udp_size {
    validate_integer($max_udp_size, 65536, 0)
  }
  if $minimal_responses {
    validate_bool($minimal_responses)
  }
  if $msg_buffer_size {
    validate_integer($msg_buffer_size, 65552, 0)
  }
  if $msg_cache_size {
    validate_re($msg_cache_size, '^\d+[kmg]?$')
  }
  if $msg_cache_slabs {
    validate_integer($msg_cache_slabs, '', 1)
  }
  if $neg_cache_size {
    validate_re($neg_cache_size, '^\d+[kmg]?$')
  }
  if $num_queries_per_thread {
    validate_integer($num_queries_per_thread, '', 0)
  }
  if $num_threads {
    validate_integer($num_threads, '', 1)
  }
  if $outgoing_interface {
    validate_ip_address_array($outgoing_interface)
  }
  if $outgoing_num_tcp {
    validate_integer($outgoing_num_tcp, '', 0)
  }
  if $outgoing_port {
    validate_array($outgoing_port)
    validate_unbound_port($outgoing_port)
  }
  if $outgoing_range {
    validate_integer($outgoing_range, 65535, 1)
  }
  if $outgoing_tcp_mss {
    validate_integer($outgoing_tcp_mss, '', 0)
  }
  if $permit_small_holddown {
    validate_bool($permit_small_holddown)
  }
  if $pidfile {
    validate_absolute_path($pidfile)
  }
  if $port {
    validate_integer($port, 65535, 0)
  }
  if $prefetch {
    validate_bool($prefetch)
  }
  if $prefetch_key {
    validate_bool($prefetch_key)
  }
  if $private_address {
    validate_array($private_address)
    validate_unbound_acl($private_address, [], true)
  }
  if $private_domain {
    validate_array($private_domain)
    validate_domain_name($private_domain)
  }
  if $qname_minimisation {
    validate_bool($qname_minimisation)
  }
  if $ratelimit {
    validate_integer($ratelimit, '', 0)
  }
  if $ratelimit_below_domain {
    validate_array($ratelimit_below_domain)
    validate_unbound_ratelimit($ratelimit_below_domain)
  }
  if $ratelimit_factor {
    validate_integer($ratelimit_factor, '', 0)
  }
  if $ratelimit_for_domain {
    validate_array($ratelimit_for_domain)
    validate_unbound_ratelimit($ratelimit_for_domain)
  }
  if $ratelimit_size {
    validate_re($ratelimit_size, '^\d+[kmg]?$')
  }
  if $ratelimit_slabs {
    validate_integer($ratelimit_slabs, '', 1)
  }
  if $root_hints {
    validate_absolute_path($root_hints)
  }
  if $rrset_cache_size {
    validate_re($rrset_cache_size, '^\d+[kmg]?$')
  }
  if $rrset_cache_slabs {
    validate_integer($rrset_cache_slabs, '', 1)
  }
  if $rrset_roundrobin {
    validate_bool($rrset_roundrobin)
  }
  if $server_cert_file {
    validate_absolute_path($server_cert_file)
  }
  if $server_key_file {
    validate_absolute_path($server_key_file)
  }
  if $so_rcvbuf {
    validate_re($so_rcvbuf, '^\d+[kmg]?$')
  }
  if $so_reuseport {
    validate_bool($so_reuseport)
  }
  if $so_sndbuf {
    validate_re($so_sndbuf, '^\d+[kmg]?$')
  }
  if $ssl_port {
    validate_integer($ssl_port, 65535, 0)
  }
  if $ssl_service_key {
    validate_absolute_path($ssl_service_key)
  }
  if $ssl_service_pem {
    validate_absolute_path($ssl_service_pem)
  }
  if $ssl_upstream {
    validate_bool($ssl_upstream)
  }
  if $statistics_cumulative {
    validate_bool($statistics_cumulative)
  }
  if $statistics_interval {
    validate_integer($statistics_interval, '', 0)
  }
  if $target_fetch_policy {
    validate_re($target_fetch_policy, '^(?:-1|\d+)(?: (?:-1|\d+)){4}$')
  }
  if $tcp_mss {
    validate_integer($tcp_mss, '', 0)
  }
  if $tcp_upstream {
    validate_bool($tcp_upstream)
  }
  if $trust_anchor {
    validate_array($trust_anchor)
  }
  if $trust_anchor_file {
    validate_absolute_path($trust_anchor_file)
  }
  if $unblock_lan_zones {
    validate_bool($unblock_lan_zones)
  }
  if $unwanted_reply_threshold {
    validate_integer($unwanted_reply_threshold, '', 0)
  }
  if $use_caps_for_id {
    validate_bool($use_caps_for_id)
  }
  if $use_syslog {
    validate_bool($use_syslog)
  }
  validate_string($username)
  if $val_bogus_ttl {
    validate_integer($val_bogus_ttl, '', 0)
  }
  if $val_clean_additional {
    validate_bool($val_clean_additional)
  }
  if $val_log_level {
    validate_integer($val_log_level, 2, 0)
  }
  if $val_nsec3_keysize_iterations {
    validate_re($val_nsec3_keysize_iterations, '^\d+ \d+(?: \d+ \d+)*$')
  }
  validate_string($val_override_date)
  if $val_permissive_mode {
    validate_bool($val_permissive_mode)
  }
  if $val_sig_skew_max {
    validate_integer($val_sig_skew_max, '', 0)
  }
  if $val_sig_skew_min {
    validate_integer($val_sig_skew_min, '', 0)
  }
  if $verbosity {
    validate_integer($verbosity, 5, 0)
  }
  validate_string($version)

  include ::unbound::install
  include ::unbound::config
  include ::unbound::service

  anchor { 'unbound::begin': }
  anchor { 'unbound::end': }

  Anchor['unbound::begin'] -> Class['::unbound::install']
    ~> Class['::unbound::config'] ~> Class['::unbound::service']
    -> Anchor['unbound::end']
}
