meta "power" do
  accepts_value_for :type
  accepts_value_for :property
  accepts_value_for :value

  name_for = {
    :ac => "AC Power",
    :battery => "Battery Power"
  }

  switch_for = {
    :ac => "-c",
    :battery => "-b"
  }
  
  template {
    command = "pmset -g custom" +
              " | awk '/#{name_for[type]}/,0 { if (/^ /) print; if (!/#{name_for[type]}/ && !/^ /) exit }'" +
              " | grep ' #{property} '" +
              " | awk  '{ print $2 }'"
    
    met? {
      shell?(command) && shell(command) == value
    }

    meet {
      shell "sudo /usr/bin/pmset #{switch_for[type]} #{property} #{value}"
    }
  }
end
