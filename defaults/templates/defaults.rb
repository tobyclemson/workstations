meta "defaults" do
  accepts_value_for :domain
  accepts_value_for :key
  accepts_list_for :value

  template {
    def resolved_value
      if value.length == 1
        value[0]
      else
        value
      end
    end

    def read_value
      case resolved_value
      when Array
        ["(\n", resolved_value.map { |e| "    #{e}" }.join(",\n"), "\n", ")\n"].flatten.join
      when true
        "1"
      when false
        "0"
      else
        resolved_value.to_s
      end
    end

    def type
      return "array" if resolved_value.is_a? Array
      return "bool"  if [true, false].include? resolved_value
      return "int"   if resolved_value.is_a? Integer
      return "float" if resolved_value.is_a? Float
      return "string"
    end

    def write_value
      case resolved_value
      when Array
        "'(#{resolved_value.join(',')})'"
      else
        resolved_value.to_s.include?(" ") ? "'#{resolved_value.to_s}'" : resolved_value.to_s
      end
    end

    met? { `defaults read #{domain} #{key}`.strip == read_value }
    meet { log_shell "Setting #{domain} #{key} to #{write_value}", "defaults write #{domain} #{key} -#{type} #{write_value}" }
  }
end
