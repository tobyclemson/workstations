meta "power" do
  accepts_value_for :type
  accepts_value_for :property
  accepts_value_for :value

  name_for = 

  switch_for = 

  template {
    def name_for type
      {:ac => "AC Power", :battery => "Battery Power"}[type]
    end

    def switch_for type
      {:ac => "-c", :battery => "-b"}[type]
    end
    
    def command
      "pmset -g custom" +
        " | awk '/#{name_for(type)}/,0 { if (/^ /) print; if (!/#{name_for(type)}/ && !/^ /) exit }'" +
        " | grep ' #{property} '" +
        " | awk  '{ print $2 }'"
    end

    met? {
      shell?(command) && shell(command) == value
    }

    meet {
      shell "sudo /usr/bin/pmset #{switch_for(type)} #{property} #{value}"
    }
  }
end
