meta :plist do
  accepts_value_for :target
  accepts_list_for :entries

  template {
    setup {
      requires 'plist exists'.with(target: target)
    }

    def plistbuddy
      '/usr/libexec/PlistBuddy'
    end

    def add_entry path, type, target
      "#{plistbuddy} -c \"Add #{path} #{type}\" \"#{File.expand_path(target)}\""
    end

    def set_entry path, value, target
      "#{plistbuddy} -c \"Set #{path} #{value}\" \"#{File.expand_path(target)}\""
    end

    def hash_entry path, target
      "#{plistbuddy} -c \"Print #{path}\" \"#{File.expand_path(target)}\" | md5"
    end

    def hash_value value
      "echo '#{value}' | md5"
    end

    def check_exists path, target
      "#{plistbuddy} -c \"Print #{path}\" \"#{File.expand_path(target)}\" 2>&1 | grep -vq 'Does Not Exist'"
    end

    def check_equal path, value, target
      "bash -c \"[ \\\"$(#{hash_entry(path, target)})\\\" == \\\"$(#{hash_value(value)})\\\" ]\""
    end

    met? {
      entries.all? do |entry|
        shell?(check_exists(entry[:path], target)) && shell?(check_equal(entry[:path], entry[:value], target))
      end
    }

    meet {
      entries.each do |entry|
        shell(add_entry(entry[:path], entry[:type], target)) unless shell?(check_exists(entry[:path], target))
        shell(set_entry(entry[:path], entry[:value], target)) unless shell?(check_equal(entry[:path], entry[:value], target))
      end
    }
  }
end

dep 'plist exists', :target do
  met? {
    target.p.exist?
  }

  meet {
    shell("mkdir -p \"#{target.p.dirname}\"")
    shell("cp #{__FILE__.p.parent}/../files/empty.plist \"#{target.p.cleanpath}\"")
  }
end
