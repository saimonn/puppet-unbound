#
define unbound::forward (
  $host  = undef,
  $addr  = undef,
  $first = undef,
) {

  if ! defined(Class['::unbound']) {
    fail('You must include the unbound base class before using any unbound defined resources') # lint:ignore:80chars
  }

  validate_domain_name($name)
  if $host {
    validate_array($host)
    validate_domain_name($host)
  }
  if $addr {
    validate_array($addr)
    validate_unbound_acl($addr)
  }
  if $first {
    validate_bool($first)
  }

  ::concat::fragment { "unbound forward ${name}":
    content => template('unbound/forward.erb'),
    order   => "40-${name}",
    target  => "${::unbound::conf_dir}/unbound.conf",
  }
}
