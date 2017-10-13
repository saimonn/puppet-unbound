# @since 2.0.0
type Unbound::Record = Variant[
  Struct[{NotUndef['name'] => Bodgitlib::Zone::NonRoot, Optional['ttl'] => Integer[0], Optional['class'] => Enum['IN'], NotUndef['type'] => Enum['A'],  NotUndef['ip'] => IP::Address::V4::NoSubnet}],
  Struct[{NotUndef['name'] => Bodgitlib::Zone::NonRoot, Optional['ttl'] => Integer[0], Optional['class'] => Enum['IN'], NotUndef['type'] => Enum['AAAA'], NotUndef['ip'] => IP::Address::V6::NoSubnet}],
  Struct[{NotUndef['name'] => Bodgitlib::Zone::NonRoot, Optional['ttl'] => Integer[0], Optional['class'] => Enum['IN'], NotUndef['type'] => Enum['MX'], NotUndef['priority'] => Integer[0], NotUndef['hostname'] => Bodgitlib::Zone::NonRoot}],
  Struct[{NotUndef['name'] => Bodgitlib::Zone::NonRoot, Optional['ttl'] => Integer[0], Optional['class'] => Enum['IN'], NotUndef['type'] => Enum['NS'], NotUndef['hostname'] => Bodgitlib::Zone::NonRoot}],
  Struct[{NotUndef['name'] => Bodgitlib::Zone::NonRoot, Optional['ttl'] => Integer[0], Optional['class'] => Enum['IN'], NotUndef['type'] => Enum['PTR'], NotUndef['hostname'] => Bodgitlib::Zone::NonRoot}],
  Struct[{NotUndef['name'] => Bodgitlib::Zone::NonRoot, Optional['ttl'] => Integer[0], Optional['class'] => Enum['IN'], NotUndef['type'] => Enum['SOA'], NotUndef['primary'] => Bodgitlib::Zone::NonRoot, NotUndef['email'] => Bodgitlib::Zone::NonRoot, NotUndef['serial'] => Integer[0], NotUndef['refresh'] => Integer[0], NotUndef['retry'] => Integer[0], NotUndef['expire'] => Integer[0], NotUndef['negative'] => Integer[0]}],
  Struct[{NotUndef['name'] => Bodgitlib::Zone::NonRoot, Optional['ttl'] => Integer[0], Optional['class'] => Enum['IN'], NotUndef['type'] => Enum['TXT'], NotUndef['value'] => String}]
]
