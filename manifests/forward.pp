# Define a forward zone in Unbound.
#
# @example Use Google as forwarders
#   ::unbound::forward { '.':
#     forward_addr => [
#       '8.8.8.8',
#       '8.8.4.4',
#     ],
#   }
#
# @param zone
# @param forward_host
# @param forward_addr
# @param forward_first
# @param forward_ssl_upstream
#
# @see puppet_classes::unbound
# @see puppet_defined_types::unbound::stub
# @see puppet_defined_types::unbound::view
define unbound::forward (
  Bodgitlib::Zone                                  $zone                 = $title,
  Optional[Array[Bodgitlib::Hostname, 1]]          $forward_host         = undef,
  Optional[Array[Unbound::Interface::Incoming, 1]] $forward_addr         = undef,
  Optional[Boolean]                                $forward_first        = undef,
  Optional[Boolean]                                $forward_ssl_upstream = undef,
) {

  if ! defined(Class['::unbound']) {
    fail('You must include the unbound base class before using any unbound defined resources')
  }

  ::concat::fragment { "unbound forward ${zone}":
    content => template("${module_name}/forward.erb"),
    order   => "20-${zone}",
    target  => "${::unbound::conf_dir}/unbound.conf",
  }
}
