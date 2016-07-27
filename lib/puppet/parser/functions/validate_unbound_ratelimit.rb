#
# validate_unbound_ratelimit.rb
#

module Puppet::Parser::Functions
  newfunction(:validate_unbound_ratelimit, :doc => <<-EOS
    Validate that all passed values are all valid rate limits. Each rate
    limit should be a domain name followed by a rate specified as an
    integer.

    Example:

      validate_unbound_ratelimit(['example.com 1000', 'example.org 2000'])
    EOS
  ) do |arguments|

    raise Puppet::ParserError, 'validate_unbound_ratelimit(): Wrong number of ' +
      "arguments given (#{arguments.size} for 1)" if arguments.size != 1

    item = arguments[0]

    unless item.is_a?(Array)
      item = [item]
    end

    if item.size == 0
      raise Puppet::ParseError, 'validate_unbound_ratelimit(): Requires an array ' +
        'with at least 1 element'
    end

    item.each do |i|
      unless i.is_a?(String)
        raise Puppet::ParseError, 'validate_unbound_ratelimit(): Requires either ' +
          'an array or string to work with'
      end

      if i =~ /^ (\S+) \s+ \d+ $/x
        if not function_is_domain_name([$1])
          raise Puppet::ParseError, 'validate_unbound_ratelimit(): ' +
            "'#{i.inspect}' is not a valid ratelimit"
        end
      else
        raise Puppet::ParseError, 'validate_unbound_ratelimit(): ' +
          "'#{i.inspect}' is not a valid ratelimit"
      end
    end
  end
end
