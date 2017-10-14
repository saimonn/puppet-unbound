# Define a view in Unbound.
#
# @example Create a view
#   class { '::unbound':
#     access_control_view => [
#       ['192.0.2.0/24', 'test'],
#     ],
#   }
#
#   ::unbound::view { 'test':
#     local_zone => [
#       ['example.com.', 'typetransparent'],
#     ],
#     local_data => [
#       {
#         'name' => 'www.example.com.',
#         'type' => 'A',
#         'ip'   => '192.0.2.1',
#       },
#     ],
#   }
#
# @param view
# @param local_data
# @param local_data_ptr
# @param local_zone
# @param view_first
#
# @see puppet_classes::unbound
# @see puppet_defined_types::unbound::forward
# @see puppet_defined_types::unbound::stub
define unbound::view (
  String                                                             $view           = $title,
  Optional[Array[Unbound::Record, 1]]                                $local_data     = undef,
  Optional[Array[Unbound::Record::PTR, 1]]                           $local_data_ptr = undef,
  Optional[Array[Tuple[Bodgitlib::Zone::NonRoot, Unbound::Type], 1]] $local_zone     = undef,
  Optional[Boolean]                                                  $view_first     = undef,
) {

  if ! defined(Class['::unbound']) {
    fail('You must include the unbound base class before using any unbound defined resources')
  }

  $_local_data = $local_data ? {
    undef   => undef,
    default => $local_data.map |$x| {
      unbound::flatten_record($x)
    }
  }

  ::concat::fragment { "unbound view ${view}":
    content => template("${module_name}/view.erb"),
    order   => "30-${view}",
    target  => "${::unbound::conf_dir}/unbound.conf",
  }
}
