meta "defaults" do
  accepts_value_for :domain
  accepts_value_for :key
  accepts_value_for :value

  template {
    def read_value
      case value
      when Array
        ["(\n", value.map { |e| "    #{e}" }.join(",\n"), "\n", ")\n"].flatten.join
      when true
        "1"
      when false
        "0"
      else
        value.to_s
      end
    end

    def type
      return "array" if value.is_a? Array
      return "bool"  if [true, false].include? value
      return "int"   if value.is_a? Integer
      return "float" if value.is_a? Float
      return "string"
    end

    def write_value
      case value
      when Array
        "'(#{value.join(',')})'"
      else
        value.to_s.include?(" ") ? "'#{value.to_s}'" : value.to_s
      end
    end

    met? { `defaults read #{domain} #{key}`.strip == read_value }
    meet { log_shell "Setting #{domain} #{key} to #{write_value}", "defaults write #{domain} #{key} -#{type} #{write_value}" }
  }
end
