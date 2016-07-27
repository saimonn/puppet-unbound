#
class unbound::install {

  if $::unbound::manage_package {
    package { $::unbound::package_name:
      ensure => present,
    }
  }
}
