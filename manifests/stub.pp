#
define unbound::stub (
  $host  = undef,
  $addr  = undef,
  $prime = undef,
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
  if $prime {
    validate_bool($prime)
  }
  if $first {
    validate_bool($first)
  }

  ::concat::fragment { "unbound stub ${name}":
    content => template('unbound/stub.erb'),
    order   => "30-${name}",
    target  => "${::unbound::conf_dir}/unbound.conf",
  }
}
