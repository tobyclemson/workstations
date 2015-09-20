meta "defaults" do
  accepts_value_for :domain
  accepts_value_for :key
  accepts_value_for :value
  accepts_list_for :values

  template {
    def read_value
      if values
        return ["(\n", value.map { |e| "    #{e}" }.join(",\n"), "\n", ")\n"].flatten.join
      end

      case value
      when true
        "1"
      when false
        "0"
      else
        value.to_s
      end
    end

    def type
      return "array" if values.is_a? Array
      return "bool"  if [true, false].include? value
      return "int"   if value.is_a? Integer
      return "float" if value.is_a? Float
      return "string"
    end

    def write_value
      if values
        return "'(#{values.join(',')})'"
      end

      value.to_s.include?(" ") ? "'#{value.to_s}'" : value.to_s
    end

    met? { `defaults read #{domain} #{key}`.strip == read_value }
    meet { log_shell "Setting #{domain} #{key} to #{write_value}", "defaults write #{domain} #{key} -#{type} #{write_value}" }
  }
end
