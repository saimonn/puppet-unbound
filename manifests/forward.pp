# Define a forward zone in Unbound.
#
# @example Use Google as forwarders
#   ::unbound::forward { '.':
#     addr => [
#       '8.8.8.8',
#       '8.8.4.4',
#     ],
#   }
#
# @param zone
# @param host
# @param addr
# @param first
#
# @see puppet_classes::unbound
# @see puppet_defined_types::unbound::local
# @see puppet_defined_types::unbound::stub
define unbound::forward (
  Bodgitlib::Zone                                  $zone  = $title,
  Optional[Array[Bodgitlib::Hostname, 1]]          $host  = undef,
  Optional[Array[Unbound::Interface::Incoming, 1]] $addr  = undef,
  Optional[Boolean]                                $first = undef,
) {

  if ! defined(Class['::unbound']) {
    fail('You must include the unbound base class before using any unbound defined resources')
  }

  ::concat::fragment { "unbound forward ${zone}":
    content => template("${module_name}/forward.erb"),
    order   => "40-${zone}",
    target  => "${::unbound::conf_dir}/unbound.conf",
  }
}
