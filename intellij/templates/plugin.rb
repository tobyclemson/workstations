meta "intellijplugin" do
  accepts_value_for :name
  accepts_value_for :url
  accepts_value_for :type

  template {
    requires_when_unmet 'curl.managed'

    def intellij_support_path
      "~/Library/Application Support/IntelliJIdea14".p.cleanpath
    end

    met? {
      if type.to_sym == :zip
        "#{intellij_support_path}/#{name}".p.exist?
      elsif type.to_sym == :jar
        "#{intellij_support_path}/#{name}.jar".p.exist?
      else
        raise ArgumentError
      end
    }

    meet {
      if type.to_sym == :zip
        shell("curl #{url} -o '#{intellij_support_path}/#{name}.zip'")
        shell("unzip '#{intellij_support_path}/#{name}.zip' -d '#{intellij_support_path}'")
        shell("rm '#{intellij_support_path}/#{name}.zip'")
      elsif type.to_sym == :jar
        shell("curl #{url} -o '#{intellij_support_path}/#{name}.jar'")
      else
        raise ArgumentError
      end
    }
  }
end
