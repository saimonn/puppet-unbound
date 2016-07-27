#
# validate_unbound_acl.rb
#

require 'ipaddr'

# Patch IP class so the netmask is accessible
class IPAddr
  attr_reader :mask_addr
end

module Puppet::Parser::Functions
  newfunction(:validate_unbound_acl, :doc => <<-EOS
    Validate that all passed values are all valid IP addresses. A second
    argument passes one or more fixed strings that are valid values for
    actions that may follow the address. A final third parameter controls
    if the IP address accepts single addresses or CIDR netblocks.

    Example:

      validate_unbound_acl(['1.2.3.4', '5.6.7.8@5353'])
      validate_unbound_acl(['1.2.3.0/24 allow'], ['allow', 'deny'], true)
    EOS
  ) do |arguments|

    rescuable_exceptions = [ArgumentError]

    if defined?(IPAddr::InvalidAddressError)
      rescuable_exceptions << IPAddr::InvalidAddressError
    end

    raise Puppet::ParserError, 'validate_unbound_acl(): Wrong number of ' +
      "arguments given (#{arguments.size} for 3)" unless (1..3).include?(arguments.size)

    item     = arguments[0]
    actions  = arguments[1] || []
    extended = function_str2bool([arguments[2] || false])

    unless item.is_a?(Array)
      item = [item]
    end

    if item.size == 0
      raise Puppet::ParseError, 'validate_unbound_acl(): Requires an array ' +
        'with at least 1 element'
    end

    item.each do |i|
      unless i.is_a?(String)
        raise Puppet::ParseError, 'validate_unbound_acl(): Requires either ' +
          'an array or string to work with'
      end

      spec = i.split(/\s+/)

      case spec.size
      when 1
        # Just the address
        addr = spec[0]
        # If there is at least one action value then they're required
        if actions.size > 0
          raise Puppet::ParseError, 'validate_unbound_acl(): An action is ' +
            'expected'
        end
      when 2
        # An address followed by an action
        addr = spec[0]
        unless actions.include?(spec[1])
          raise Puppet::ParseError, 'validate_unbound_acl(): ' +
            "#{spec[1].inspect} is not a valid action"
        end
      else
        raise Puppet::ParseError, "#{i.inspect} is not a valid Unbound IP address."
      end

      # Match <address>@<port> syntax
      if addr =~ /^ ([^@]+) @ (\d+) $/x
        ip = $1
        unless $2.to_i < 65535
          raise Puppet::ParseError, "#{$2} is not a valid port."
        end
      else
        ip = addr
      end

      # Match extended IP address formats
      if extended
        case ip
        when /^ ([^\/]+) \/ (\d+) $/x
          # IP / Prefix
          begin
            unless IPAddr.new($1).mask($2).mask_addr.to_s(2).count('1') == $2.to_i
              raise Puppet::ParseError, "#{ip.inspect} is not a valid IP/Prefix pair."
            end
          rescue *rescuable_exceptions
            raise Puppet::ParseError, "#{ip.inspect} is not a valid IP/Prefix pair."
          end
        else
          # Normal IP
          begin
            x = IPAddr.new(ip)
            unless (x.ipv4? or x.ipv6?) and x.to_s.eql?(ip) and x.to_range.count == 1
              raise Puppet::ParseError, "#{ip.inspect} is not a valid IP address."
            end
          rescue *rescuable_exceptions
            raise Puppet::ParseError, "#{ip.inspect} is not a valid IP address."
          end
        end
      else
        # Normal IP
        begin
          x = IPAddr.new(ip)
          unless (x.ipv4? or x.ipv6?) and x.to_s.eql?(ip) and x.to_range.count == 1
            raise Puppet::ParseError, "#{ip.inspect} is not a valid IP address."
          end
        rescue *rescuable_exceptions
          raise Puppet::ParseError, "#{ip.inspect} is not a valid IP address."
        end
      end
    end
  end
end
