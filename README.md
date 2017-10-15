# unbound

Tested with Travis CI

[![Build Status](https://travis-ci.org/bodgit/puppet-unbound.svg?branch=master)](https://travis-ci.org/bodgit/puppet-unbound)
[![Coverage Status](https://coveralls.io/repos/bodgit/puppet-unbound/badge.svg?branch=master&service=github)](https://coveralls.io/github/bodgit/puppet-unbound?branch=master)
[![Puppet Forge](http://img.shields.io/puppetforge/v/bodgit/unbound.svg)](https://forge.puppetlabs.com/bodgit/unbound)
[![Dependency Status](https://gemnasium.com/bodgit/puppet-unbound.svg)](https://gemnasium.com/bodgit/puppet-unbound)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with unbound](#setup)
    * [Beginning with unbound](#beginning-with-unbound)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

This module manages Unbound.

RHEL/CentOS and OpenBSD are supported using Puppet 4.6.0 or later.

## Setup

### Beginning with unbound

In the simplest case, configure Unbound listening on all interfaces:

```puppet
include ::unbound
```

## Usage

Update the above example to specify the forwarders to use and allow access
from the local network, also restrict outbound ports used to avoid anything
below 32768 and above 65000:

```puppet
class { '::unbound':
  access_control => [
    ["${::network}/${netmask_to_masklen($::netmask)}", 'allow'],
    ["${::network6}/${netmask_to_masklen($::netmask6)}", 'allow'],
  ],
  outgoing_port  => [
    ['avoid', 0, 32767],
    ['avoid', 65001, 65535],
  ],
}

::unbound::forward { '.':
  forward_addr => [
    '8.8.8.8',
    '8.8.4.4',
    '2001:4860:4860::8844',
    '2001:4860:4860::8888',
  ],
}
```

Configure NSD listening on the primary interface as a slave for a single
zone protected with a given TSIG key and configure Unbound listening on
the loopback interface only with a stub zone pointing to NSD:

```puppet
class { '::nsd':
  ip_address => [
    $::ipaddress,
    $::ipaddress6,
  ],
}

::nsd::key { 'example.':
  algorithm => 'hmac-sha256',
  secret    => '6z+8iKRIQrwN43TFfO/Rf2NHzpHIFVi6PsJ7dDESclc=',
}

::nsd::zone { 'example.com.':
  allow_notify => [
    ['192.0.2.1', 'example.'],
  ],
  request_xfr  => [
    ['AXFR', '192.0.2.1', 'example.'],
  ],
}

class { '::unbound':
  interface => [
    $::ipaddress_lo,
    $::ipaddress6_lo,
  ],
}

::unbound::stub { 'example.com.':
  stub_addr => [
    $::ipaddress,
    $::ipaddress6,
  ],
}
```

If NSD is not required then local data can be used instead:

```puppet
class { '::unbound':
  interface  => [
    $::ipaddress_lo,
    $::ipaddress6_lo,
  ],
  local_zone => [
    ['example.com.', 'static'],
  ],
  local_data => [
    {
      'name'     => 'example.com.'
      'ttl'      => 86400,
      'class'    => 'IN',
      'type'     => 'NS',
      'hostname' => 'ns1.example.com.',
    },
    {
      'name'     => 'example.com.'
      'ttl'      => 86400,
      'class'    => 'IN',
      'type'     => 'SOA',
      'primary'  => 'ns1.example.com.',
      'email'    => 'hostmaster.example.com.',
      'serial'   => 1,
      'refresh'  => 10800,
      'retry'    => 15,
      'expire'   => 604800,
      'negative' => 10800,
    },
    {
      'name'  => 'ns1.example.com.',
      'ttl'   => 86400,
      'class' => 'IN',
      'type'  => 'A',
      'ip'    => '192.0.2.1',
    },
  ],
}
```

## Reference

The reference documentation is generated with
[puppet-strings](https://github.com/puppetlabs/puppet-strings) and the latest
version of the documentation is hosted at
[https://bodgit.github.io/puppet-unbound/](https://bodgit.github.io/puppet-unbound/).

## Limitations

This module has been built on and tested against Puppet 4.6.0 and higher.

The module has been tested on:

* RedHat Enterprise Linux 6/7
* OpenBSD 6.0/6.1

## Development

The module has both [rspec-puppet](http://rspec-puppet.com) and
[beaker-rspec](https://github.com/puppetlabs/beaker-rspec) tests. Run them
with:

```
$ bundle exec rake test
$ PUPPET_INSTALL_TYPE=agent PUPPET_INSTALL_VERSION=x.y.z bundle exec rake beaker:<nodeset>
```

Please log issues or pull requests at
[github](https://github.com/bodgit/puppet-unbound).
