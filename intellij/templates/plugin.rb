meta "intellijplugin" do
  accepts_value_for :name
  accepts_value_for :url
  accepts_value_for :type

  template {
    requires_when_unmet 'curl.managed'
    requires_when_unmet 'unzip.managed'

    met? {
      if type.to_sym == :zip
        "~/Library/Application Support/IntelliJIdea14/#{name}".p.exist?
      elsif type.to_sym == :jar
        "~/Library/Application Support/IntelliJIdea14/#{name}.jar".p.exist?
      else
        raise ArgumentError
      end
    }

    meet {
      if type.to_sym == :zip
        shell("curl #{url} -o ~/Library/Application\ Support/IntelliJIdea14/#{name}.zip")
        shell("unzip ~/Library/Application\ Support/IntelliJIdea14/#{name}.zip -d ~/Library/Application\ Support/IntelliJIdea14/")
        shell("rm ~/Library/Application\ Support/IntelliJIdea14/#{name}.zip")
      elsif type.to_sym == :jar
        shell("curl #{url} -o ~/Library/Application\ Support/IntelliJIdea14/#{name}.jar")
      else
        raise ArgumentError
      end
    }
  }
end
