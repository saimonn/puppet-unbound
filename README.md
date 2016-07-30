# unbound

Tested with Travis CI

[![Build Status](https://travis-ci.org/bodgit/puppet-unbound.svg?branch=master)](https://travis-ci.org/bodgit/puppet-unbound)
[![Coverage Status](https://coveralls.io/repos/bodgit/puppet-unbound/badge.svg?branch=master&service=github)](https://coveralls.io/github/bodgit/puppet-unbound?branch=master)
[![Puppet Forge](http://img.shields.io/puppetforge/v/bodgit/unbound.svg)](https://forge.puppetlabs.com/bodgit/unbound)
[![Dependency Status](https://gemnasium.com/bodgit/puppet-unbound.svg)](https://gemnasium.com/bodgit/puppet-unbound)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with unbound](#setup)
    * [What unbound affects](#what-unbound-affects)
    * [Beginning with unbound](#beginning-with-unbound)
4. [Usage - Configuration options and additional functionality](#usage)
    * [Classes and Defined Types](#classes-and-defined-types)
        * [Class: unbound](#class-unbound)
        * [Defined Type: unbound::forward](#defined-type-unboundforward)
        * [Defined Type: unbound::local](#defined-type-unboundlocal)
        * [Defined Type: unbound::stub](#defined-type-unboundstub)
    * [Functions](#functions)
        * [Function: validate_unbound_acl](#function-validate_unbound_acl)
        * [Function: validate_unbound_port](#function-validate_unbound_port)
        * [Function: validate_unbound_ratelimit](#function-validate_unbound_ratelimit)
    * [Examples](#examples)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module manages Unbound.

## Module Description

This module can install the Unbound package, manage the main configuration
file and service. It also maintains a DNSSEC trust anchor so it can validate
queries.

## Setup

### What unbound affects

* The package providing the Unbound software.
* The `unbound.conf` configuration file.
* The service controlling the Unbound daemon.
* A DNSSEC trust anchor.

### Beginning with unbound

```puppet
include ::unbound
```

## Usage

### Classes and Defined Types

#### Class: `unbound`

**Parameters within `unbound`:**

##### `conf_dir`

The base configuration directory, usually either `/etc/unbound` or `/var/unbound/etc`.

##### `enable_dns64`

Enable the `dns64` module.

##### `enable_dnssec`

Enable the `validator` module thus enabling DNSSEC query validation.

##### `group`

The primary group of the dedicated user used to run Unbound.

##### `manage_control`

Whether to use `unbound-control-setup` to create the remote control certificates
and keys.

##### `manage_package`

Whether to manage a package or not. Some operating systems have Unbound as
part of the base system.

##### `package_name`

The name of the package to install that provides the Unbound software.

##### `service_name`

The name of the service managing the Unbound daemon.

##### `access_control`

Array of access control entries. Each entry is an IP netblock followed by one
of `deny`, `refuse`, `allow`, `allow_snoop`, `deny_non_local` or
`refuse_non_local`.

```puppet
class { '::unbound':
  access_control => [
    '192.0.2.0/24 allow',
  ],
}
```

##### `add_holddown`

Add new trust anchors only after they've been visible for this amount of time.

##### `auto_trust_anchor_file`

Path to the trust anchor file tracked with RFC 5011 probes. This file is
created first with `unbound-anchor`.

##### `cache_max_negative_ttl`

Time to live maximum for negative responses.

##### `cache_max_ttl`

Maximum TTL for cache entries.

##### `cache_min_ttl`

Minimum TTL for cache entries.

##### `caps_whitelist`

Array of domains to whitelist so that it does not receive caps-for-id perturbed
queries.

##### `chroot`

Directory to chroot to on startup.

##### `control_cert_file`

Path to the control client certificate file.

##### `control_enable`

Whether to enable remote control.

##### `control_interface`

Array of interfaces to listen on for remote control requests.

##### `control_key_file`

Path to the control client key file.

##### `control_port`

Port to listen on for remote control requests.

##### `control_use_cert`

Whether to require certificate authentication of control connections.

##### `del_holddown`

Remove trust anchors only after they've been revoked for this amount of time.

##### `delay_close`

Extra delay for timeouted UDP ports before they are closed.

##### `directory`

Sets the working directory.

##### `disable_dnssec_lame_check`

Disables the DNSSEC lameness check in the iterator.

##### `do_ip4`

Listen to IPv4 connections.

##### `do_ip6`

Listen to IPv6 connections.

##### `do_not_query_address`

Array of IP addresses/subnets never to send queries to.

##### `do_not_query_localhost`

Also include localhost as an address never to query.

##### `do_tcp`

Control whether TCP is ever used.

##### `do_udp`

Control whether UDP is ever used.

##### `domain_insecure`

Array of domains to ignore for the purposes of DNSSEC validation.

##### `dns64_prefix`

This sets the DNS64 prefix to use to synthesize AAAA records with.

##### `dns64_synthall`

If enabled, synthesize all AAAA records despite the presence of actual AAAA
records.

##### `edns_buffer_size`

Number of bytes size to advertise as the EDNS reassembly buffer size.

##### `extended_statistics`

Enable extended statistics.

##### `harden_algo_downgrade`

Harden against algorithm downgrade when multiple algorithms are advertised in
the DS record.

##### `harden_below_nxdomain`

Tuning option for DNSSEC interoperability.

##### `harden_dnssec_stripped`

Require DNSSEC data for trust-anchored zones.

##### `harden_glue`

Trust glue only if it is within the servers authority.

##### `harden_large_queries`

Very large queries are ignored.

##### `harden_referral_path`

Harden the referral path by performing additional queries for infrastructure data.

##### `harden_short_bufsize`

Very small EDNS buffer sizes from queries are ignored.

##### `hide_identity`

Prevent Unbound from replying with its identity.

##### `hide_version`

Prevent Unbound from replying with its version.

##### `identity`

Returns this specified identity when asked.

##### `ignore_cd_flag`

Instruct unbound to ignore the CD flag from clients and refuse to return bogus answers to them.

##### `incoming_num_tcp`

Number of incoming TCP buffers to allocate per thread.

##### `infra_host_ttl`

Time to live for entries in the host cache.

##### `infra_cache_min_rtt`

Lower limit for dynamic retransmit timeout calculation in infrastructure cache.

##### `infra_cache_numhosts`

Number of hosts for which information is cached.

##### `infra_cache_slabs`

Number of slabs in the infrastructure cache.

##### `insecure_lan_zones`

If enabled, then reverse lookups in private address space are not validated.

##### `interface`

Array of interfaces to listen on for DNS requests.

##### `interface_automatic`

Detect source interface on UDP queries and copy them to replies.

##### `ip_freebind`

Use `IP_FREEBIND` socket option on sockets where unbound is listening to
incoming traffic.

##### `ip_transparent`

Use `IP_TRANSPARENT` socket option on sockets where unbound is listening for
incoming traffic.

##### `jostle_timeout`

Timeout used when the server is very busy.

##### `keep_missing`

Remove missing trust anchors only after they've been unseen for this amount
of time.

##### `key_cache_size`

Number of bytes size of the key cache.

##### `key_cache_slabs`

Number of slabs in the key cache.

##### `log_queries`

Prints one line per query to the log, with the log timestamp and IP address,
name, type and class.

##### `log_time_ascii`

Log time in ASCII.

##### `logfile`

Log messages to this file.

##### `max_udp_size`

Maximum UDP response size.

##### `minimal_responses`

Don't insert authority/additional sections into response messages when those
sections are not required.

##### `msg_buffer_size`

Number of bytes size of the message buffers.

##### `msg_cache_size`

Number of bytes size of the message cache.

##### `msg_cache_slabs`

Number of slabs in the message cache.

##### `neg_cache_size`

Number of bytes size of the aggressive negative cache.

##### `num_queries_per_thread`

The number of queries that every thread will service simultaneously.

##### `num_threads`

The number of threads to create to serve clients.

##### `outgoing_interface`

Array of interfaces to use to connect to the network.

##### `outgoing_num_tcp`

Number of outgoing TCP buffers to allocate per thread.

##### `outgoing_port`

An array of strings of the form `permit|avoid port[-port]` which will be
converted into `outgoing-port-permit` and `outgoing-port-avoid` configuration
directives with the same order.

```puppet
class { '::unbound':
  outgoing_port => [
    'avoid 0-32767',
    'avoid 65001-65535',
  ],
}
```

##### `outgoing_range`

Number of ports to open.

##### `outgoing_tcp_mss`

Maximum segment size (MSS) of TCP socket for outgoing queries.

##### `permit_small_holddown`

Allows the autotrust 5011 rollover timers to assume very small values.

##### `pidfile`

Path to PID file.

##### `port`

Default port to listen on for DNS requests.

##### `prefetch`

Message cache elements are prefetched before they expire to keep the cache up to date.

##### `prefetch_key`

If yes, fetch the DNSKEYs earlier in the validation process, when a DS record
is encountered.

##### `private_address`

Array of IP addresses or subnets which are removed from responses if present.

##### `private_domain`

Allow this domain, and all its subdomains to contain private addresses.

##### `qname_minimisation`

Send minimum amount of information to upstream servers to enhance privacy.

##### `ratelimit`

The ratelimit is in queries per second that are allowed.

##### `ratelimit_below_domain`

Array of domains to override the global ratelimit for a domain name that ends
in this name.

```puppet
class { '::unbound':
  ratelimit_below_domain => [
    'example.com 1000',
  ],
}
```

##### `ratelimit_factor`

Set the amount of queries to rate limit when the limit is exceeded.

##### `ratelimit_for_domain`

Array of domains to override the global ratelimit for a domain that matches
exactly.

```puppet
class { '::unbound':
  ratelimit_for_domain => [
    'example.com 1000',
  ],
}
```

##### `ratelimit_size`

Give the size of the data structure in which the current ongoing rates are kept
track in.

##### `ratelimit_slabs`

Give power of 2 number of slabs.

##### `root_hints`

Read the root hints from this file.

##### `rrset_cache_size`

Number of bytes size of the RRset cache.

##### `rrset_cache_slabs`

Number of slabs in the RRset cache.

##### `rrset_roundrobin`

Rotate the RRset order in responses.

##### `server_cert_file`

Path to the control server certificate file.

##### `server_key_file`

Path to the control server key file.

##### `so_rcvbuf`

Set the `SO_RCVBUF` socket option to get more buffer space on UDP port 53
incoming queries.

##### `so_reuseport`

Use the `SO_REUSEPORT` socket option.

##### `so_sndbuf`

Set the `SO_SNDBUF` socket option to get more buffer space on UDP port 53
outgoing queries.

##### `ssl_port`

The port number on which to provide TCP SSL service.

##### `ssl_service_key`

The file is the private key for the TLS session.

##### `ssl_service_pem`

The public key certificate pem file for the ssl service.

##### `ssl_upstream`

Whether the upstream queries use SSL only for transport.

##### `statistics_cumulative`

Statistics are cumulative since starting unbound.

##### `statistics_interval`

The number of seconds between printing statistics to the log for every thread.

##### `target_fetch_policy`

Set the target fetch policy used by unbound to determine if it should fetch
nameserver target addresses opportunistically.

##### `tcp_mss`

Maximum segment size (MSS) of TCP socket on which the server responds to
queries.

##### `tcp_upstream`

Whether the upstream queries use TCP only for transport.

##### `trust_anchor`

An array of DS or DNSKEY RR for a key to use for validation.

##### `trust_anchor_file`

File with trusted keys for validation.

##### `unblock_lan_zones`

If enabled, then for private address space, the reverse lookups are no longer
filtered.

##### `unwanted_reply_threshold`

Threshold for when to clear the RRset and message caches.

##### `use_caps_for_id`

Use 0x20-encoded random bits in the query to foil spoof attempts.

##### `use_syslog`

Sets unbound to send log messages to the syslogd.

##### `username`

Dedicated user used to run Unbound.

##### `val_bogus_ttl`

The time to live for bogus data.

##### `val_clean_additional`

Instruct the validator to remove data from the additional section of secure
messages that are not signed properly.

##### `val_log_level`

Have the validator print validation failures to the log.

##### `val_nsec3_keysize_iterations`

List of keysize and iteration count values.

##### `val_override_date`

If enabled by giving a RRSIG style date, that date is used for verifying RRSIG
inception and expiration dates, instead of the current date.

##### `val_permissive_mode`

Instruct the validator to mark bogus messages as indeterminate.

##### `val_sig_skew_max`

Maximum number of seconds of clock skew to apply to validated signatures.

##### `val_sig_skew_min`

Minimum number of seconds of clock skew to apply to validated signatures.

##### `verbosity`

Verbosity level for non-debug logging.

##### `version`

Override the version returned in queries.

#### Defined Type: `unbound::forward`

**Parameters within `unbound::forward`:**

##### `name`

The name of the forward zone which should be a proper domain name.

##### `host`

An array of hostnames of recursive nameservers to use.

##### `addr`

An array of IP addresses of recursive nameservers to use.

##### `first`

Try direct if the query fails against the configured nameservers.

#### Defined Type: `unbound::local`

**Parameters within `unbound::local`:**

##### `name`

The name of the local zone which should be a proper domain name.

##### `type`

One of `deny`, `refuse`, `static`, `transparent`, `typetransparent`,
`redirect`, `inform`, `inform_deny` or `nodefault`.

##### `data`

An array of entries in the form accepted by the `local-data` configuration
directive.

##### `ptr`

An array of entries in the form accepted by the `local-data-ptr` configuration
directive.

#### Defined Type: `unbound::stub`

**Parameters within `unbound::stub`:**

##### `name`

The name of the stub zone which should be a proper domain name.

##### `host`

An array of hostnames of authoritative nameservers to use.

##### `addr`

An array of IP addresses of authoritative nameservers to use.

##### `prime`

Perform NS set priming for the zone.

##### `first`

Try direct if the query fails against the configured nameservers.

### Functions

#### Function: `validate_unbound_acl`

Validate an array of IP addresses. An optional second parameter specifies any
strings that are valid actions to follow the IP address. An optional final
boolean parameter specifies whether just single IP addresses are accepted
(the default) or CIDR ranges are also accepted.

~~~
validate_unbound_acl(['1.2.3.0/24'], [], true)
validate_unbound_acl(['1.2.3.4 allow'], ['allow', 'refuse'])
~~~

#### Function: `validate_unbound_port`

Validate an array of port specifications. Each specification begins with
either `permit` or `avoid` followed by a single port or a range joined with
`-`.

~~~
validate_unbound_port(['permit 1024-65535', 'avoid 2000', 'avoid 3000'])
validate_unbound_port(['avoid 0-32767', 'avoid 65001-65535'])
~~~

#### Function: `validate_unbound_ratelimit`

Validate an array of ratelimits. Each ratelimit begins with a domain name,
followed by an integer specifying a rate.

~~~
validate_unbound_ratelimit(['example.com. 1000', 'example.org. 2000'])
~~~

### Examples

Configure Unbound listening on all interfaces:

```puppet
include ::unbound
```

Update the above example to specify the forwarders to use and allow access
from the local network, also restrict outbound ports used to avoid anything
below 32768 and above 65000:

```puppet
# Convert netmasks to CIDR prefix
$cidr = inline_template("<%= IPAddr::new('$::netmask').to_i.to_s(2).count('1') %>")
$cidr6 = inline_template("<%= IPAddr::new('$::netmask6').to_i.to_s(2).count('1') %>")

class { '::unbound':
  access_control => [
    "${::network}/${cidr} allow",
    "${::network6}/${cidr6} allow",
  ],
  outgoing_port  => [
    'avoid 0-32767',
    'avoid 65001-65535',
  ],
}

::unbound::forward { '.':
  addr => [
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

::nsd::key { 'example':
  algorithm => 'hmac-sha256',
  secret    => '6z+8iKRIQrwN43TFfO/Rf2NHzpHIFVi6PsJ7dDESclc=',
}

::nsd::zone { 'example.com.':
  allow_notify => [
    '192.0.2.1 example',
  ],
  request_xfr  => [
    'AXFR 192.0.2.1 example',
  ],
}

class { '::unbound':
  interface => [
    $::ipaddress_lo,
    $::ipaddress6_lo,
  ],
}

::unbound::stub { 'example.com.':
  addr => [
    $::ipaddress,
    $::ipaddress6,
  ],
}
```

If NSD is not required then local data can be used instead:

```puppet
class { '::unbound':
  interface => [
    $::ipaddress_lo,
    $::ipaddress6_lo,
  ],
}

::unbound::local { 'example.com.':
  type => 'static',
  data => [
    'example.com. 86400 IN NS ns1.example.com.',
    'example.com. 86400 IN SOA ns1.example.com. hostmaster.example.com. 1 10800 15 604800 10800',
    'ns1.example.com. 86400 IN A 192.0.2.1',
  ],
}
```

## Reference

### Classes

#### Public Classes

* [`unbound`](#class-unbound): Main class for managing Unbound.

#### Private Classes

* `unbound::install`: Handles Unbound installation.
* `unbound::config`: Handles Unbound configuration.
* `unbound::params`: Different configuration data for different systems.
* `unbound::service`: Manages the `unbound` service.

### Defined Types

#### Public Defined Types

* [`unbound::forward`](#defined-type-unboundforward): Handles defining forward
  zones.
* [`unbound::local`](#defined-type-unboundlocal): Handles defining local zone
  data.
* [`unbound::stub`](#defined-type-unboundstub): Handles defining stub zones.

### Functions

* [`validate_unbound_acl`](#function-validate_unbound_acl): Validate Unbound
  ACL entries.
* [`validate_unbound_port`](#function-validate_unbound_port): Validate Unbound
  port specifications.
* [`validate_unbound_ratelimit`](#function-validate_unbound_ratelimit):
  Validate Unbound ratelimit entries.

## Limitations

This module exposes all of the various Unbound configuration options with
some exceptions:

1. The various DLV (DNSSEC Lookaside Validation) parameters are not exposed
   as it's recommended to cease using that service.

Any configuration option that accepts `yes`/`no` values are coerced to native
Puppet boolean values. Any multi-valued setting accepts an array of values.

This module has been built on and tested against Puppet 3.0 and higher.

The module has been tested on:

* RedHat/CentOS Enterprise Linux 6/7
* OpenBSD 5.8/5.9

Testing on other platforms has been light and cannot be guaranteed.

## Development

Please log issues or pull requests at
[github](https://github.com/bodgit/puppet-unbound).
