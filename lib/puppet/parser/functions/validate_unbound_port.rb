#
# validate_unbound_port.rb
#

module Puppet::Parser::Functions
  newfunction(:validate_unbound_port, :doc => <<-EOS
    Validate that all passed values are all valid port specifications.
    Each specification must begin with either `permit` or `avoid` followed
    by either a single port or a range joined with `-`.

    Example:

      validate_unbound_port(['permit 1000', 'avoid 500-510'])
    EOS
  ) do |arguments|

    raise Puppet::ParserError, 'validate_unbound_port(): Wrong number of ' +
      "arguments given (#{arguments.size} for 1)" if arguments.size != 1

    item = arguments[0]

    unless item.is_a?(Array)
      item = [item]
    end

    if item.size == 0
      raise Puppet::ParseError, 'validate_unbound_port(): Requires an array ' +
        'with at least 1 element'
    end

    item.each do |i|
      unless i.is_a?(String)
        raise Puppet::ParseError, 'validate_unbound_port(): Requires either ' +
          'an array or string to work with'
      end

      if i =~ /^ (?:permit|avoid) \s+ (\d+) (?:-(\d+))? $/x
        from = $1.to_i
        to   = $2 ? $2.to_i : nil
        if from > 65535 or (to and (to > 65535 or to <= from))
          raise Puppet::ParseError, 'validate_unbound_port(): ' +
            "'#{i.inspect}' is not a valid port"
        end
      else
        raise Puppet::ParseError, 'validate_unbound_port(): ' +
          "'#{i.inspect}' is not a valid port"
      end
    end
  end
end
