# Define a stub zone in Unbound.
#
# @example Create a stub zone
#   ::unbound::stub { 'example.com.':
#     stub_addr => [
#       '192.0.2.1',
#       '2001:db8::1',
#     ],
#   }
#
# @param zone
# @param stub_host
# @param stub_addr
# @param stub_prime
# @param stub_first
# @param stub_ssl_upstream
#
# @see puppet_classes::unbound
# @see puppet_defined_types::unbound::forward
# @see puppet_defined_types::unbound::view
define unbound::stub (
  Bodgitlib::Zone                                  $zone              = $title,
  Optional[Array[Bodgitlib::Hostname, 1]]          $stub_host         = undef,
  Optional[Array[Unbound::Interface::Incoming, 1]] $stub_addr         = undef,
  Optional[Boolean]                                $stub_prime        = undef,
  Optional[Boolean]                                $stub_first        = undef,
  Optional[Boolean]                                $stub_ssl_upstream = undef,
) {

  if ! defined(Class['::unbound']) {
    fail('You must include the unbound base class before using any unbound defined resources')
  }

  ::concat::fragment { "unbound stub ${zone}":
    content => template("${module_name}/stub.erb"),
    order   => "10-${zone}",
    target  => "${::unbound::conf_dir}/unbound.conf",
  }
}
