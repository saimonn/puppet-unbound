# Flatten a record type to its string form.
#
# The string will include surrounding quotes as these differ depending on the
# record type.
#
# @param value The record to flatten.
#
# @return [String] The flattened string.
#
# @example
#   unbound::flatten_record({'name' => 'example.com.', 'type' => 'A', 'ip' => '192.0.2.1'})
#
# @since 2.0.0
function unbound::flatten_record(Unbound::Record $value) {

  $header = delete_undef_values($value['name', 'ttl', 'class', 'type'])

  $value['type'] ? {
    'A'     => "\"${join($header + $value['ip'], ' ')}\"",
    'AAAA'  => "\"${join($header + $value['ip'], ' ')}\"",
    'MX'    => "\"${join($header + $value['priority', 'hostname'], ' ')}\"",
    'NS'    => "\"${join($header + $value['hostname'], ' ')}\"",
    'PTR'   => "\"${join($header + $value['hostname'], ' ')}\"",
    'SOA'   => "\"${join($header + $value['primary', 'email', 'serial', 'refresh', 'retry', 'expire', 'negative'], ' ')}\"",
    'TXT'   => "'${join($header + "\"${value['value']}\"", ' ')}'",
    default => fail("Unsupported type '${value['type']}'"),
  }
}
