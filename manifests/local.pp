#
define unbound::local (
  $type,
  $data = [],
  $ptr  = [],
) {

  if ! defined(Class['::unbound']) {
    fail('You must include the unbound base class before using any unbound defined resources') # lint:ignore:80chars
  }

  validate_domain_name($name)
  validate_re($type, '^(?:deny|refuse|static|(?:type)?transparent|redirect|nodefault|inform(?:_deny)?)$') # lint:ignore:80chars
  # FIXME Perform proper validation on these at some point
  validate_array($data)
  validate_array($ptr)
  if $type == 'nodefault' and (size($data) > 0 or size($ptr) > 0) {
    fail("There should be no zone data specified with zone '${name}' of type 'nodefault'") # lint:ignore:80chars
  }

  ::concat::fragment { "unbound local ${name}":
    content => template('unbound/local.erb'),
    order   => "10-${name}",
    target  => "${::unbound::conf_dir}/unbound.conf",
  }
}
