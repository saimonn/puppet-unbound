# @since 2.0.0
type Unbound::ACL = Tuple[IP::Address, Enum['allow', 'allow_snoop', 'deny', 'deny_non_local', 'refuse', 'refuse_non_local']]
