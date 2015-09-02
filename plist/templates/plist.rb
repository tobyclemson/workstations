# Sets particular values in a Property List file
#
#   * domain: The plist domain to manage
#   * values: A Hash mapping keys in the domain to their target values
#   * checks: A Hash mapping keys to a regex or string pattern to check
#             for to determine the "met?"-ness of that key. This is
#             useful for complex values (e.g. a hash or array) which
#             may be difficult to compare equality with. If omitted,
#             the "values" Hash will be used (which is fine for simple
#             or scalar values)
#   * types:  A Hash mapping keys to the type to use when setting each
#             key (optional, "string" will be used for any keys missing
#             from this hash)
meta :plist do
  accepts_value_for :domain
  accepts_list_for :values
  accepts_list_for :checks
  accepts_list_for :types, [Hash.new('string')]

  template {
    # Fetches a value for a particular key from a particular domain
    #
    #   * domain: The domain to fetch the value from
    #   * key:    The key of the value to fetch
    def fetch(domain, key)
      shell! 'defaults', 'read', domain, key
    rescue
      nil
    end

    # Sets a value for a particular key in a particular domain
    #
    #   * domain: The domain to write the value to
    #   * key:    The key to write the value to
    #   * value:  The value to write
    #   * type:   The type of the value (optional, one of "string",
    #             "data", "int", "integer", "float", "bool", "boolean",
    #             "date", "array", "array-add", "dict", or "dict-add").
    def set(domain, key, value, type = nil)
      command = ['defaults', 'write', domain, key]
      command << "-#{type}" unless type.nil?
      command << value.to_s
      log command.join(' ')
      shell! *command
    end

    # If value is an array, return the first item, else return value
    def unwrap(value)
      if value.instance_of?(Array) && !value.instance_of?(Hash)
        value.first
      else
        value
      end
    end

    # Retrieves the "checks" array, calculating it if not set
    def checks_value
      return unwrap(checks) unless checks.empty?
      unwrap(values).reduce(Hash.new) do |acc, (key, value)|
        unless [String, Numeric].any? {|t| value.is_a? t }
          unmeetable! <<-END.gsub(/ {12}/, '')
            Need an explicit "checks" hash, as "values" is too complex
          END
        end
        acc.tap {|a| a[key] = value.to_s }
      end
    end

    met? {
      checks_value.all? do |key, value|
        value = value.to_s unless value.is_a?(String) || value.is_a?(Regexp)
        fetch(domain, key).match(value) rescue false
      end
    }

    meet {
      unwrap(values).each do |key, value|
        set domain, key, value.to_s, unwrap(types)[key]
      end
    }
  }
end
