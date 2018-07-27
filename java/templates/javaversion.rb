meta :javaversion do
  accepts_value_for :version

  template {
    met? {
      shell?("jenv versions | grep #{version}")
    }

    meet {
      base_path = shell("find /Library/Java/JavaVirtualMachines -depth 1 -type d -name '*#{version}*'")
      shell("jenv add #{base_path}/Contents/Home")
    }
  }
end
