# @since 2.0.0
type Unbound::Data::PTR = Struct[{NotUndef['ip'] => IP::Address::NoSubnet, NotUndef['hostname'] => Bodgitlib::Zone::NonRoot, Optional['ttl'] => Integer[0]}]
