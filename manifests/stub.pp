# Define a stub zone in Unbound.
#
# @example Create a stub zone
#   ::unbound::stub { 'example.com.':
#     addr => [
#       '192.0.2.1',
#       '2001:db8::1',
#     ],
#   }
#
# @param zone
# @param host
# @param addr
# @param prime
# @param first
#
# @see puppet_classes::unbound
# @see puppet_defined_types::unbound::forward
# @see puppet_defined_types::unbound::local
define unbound::stub (
  Bodgitlib::Zone                                  $zone  = $title,
  Optional[Array[Bodgitlib::Hostname, 1]]          $host  = undef,
  Optional[Array[Unbound::Interface::Incoming, 1]] $addr  = undef,
  Optional[Boolean]                                $prime = undef,
  Optional[Boolean]                                $first = undef,
) {

  if ! defined(Class['::unbound']) {
    fail('You must include the unbound base class before using any unbound defined resources')
  }

  ::concat::fragment { "unbound stub ${zone}":
    content => template("${module_name}/stub.erb"),
    order   => "30-${zone}",
    target  => "${::unbound::conf_dir}/unbound.conf",
  }
}
