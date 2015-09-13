meta :plist do
  accepts_value_for :target
  accepts_list_for :entries

  template {
    setup {
      requires 'plist exists'.with(target: target)
    }

    def resolve target
      target.p.cleanpath
    end

    def check_path entry
      case entry[:type]
      when 'hash-entry' then "#{entry[:hash_path]}#{entry[:key_path]}"
      else entry[:path]
      end
    end

    def plistbuddy
      '/usr/libexec/PlistBuddy'
    end

    def add_entry path, type, target
      "#{plistbuddy} -c \"Add #{path} #{type}\" \"#{resolve(target)}\""
    end

    def set_entry path, value, target
      "#{plistbuddy} -c \"Set #{path} #{value}\" \"#{resolve(target)}\""
    end

    def merge_entry path, file, target
      "#{plistbuddy} -c \"Merge #{resolve(file)} #{path}\" \"#{resolve(target)}\""
    end

    def delete_entry path, target
      "#{plistbuddy} -c \"Delete #{path}\" \"#{resolve(target)}\""
    end

    def hash_entry path, target
      "#{plistbuddy} -c \"Print #{path}\" \"#{resolve(target)}\" | md5"
    end

    def hash_value value
      "echo '#{value}' | md5"
    end

    def check_exists path, target
      "#{plistbuddy} -c \"Print #{path}\" \"#{resolve(target)}\" 2>&1 | grep -vq 'Does Not Exist'"
    end

    def check_equal left_command, right_command
      "bash -c \"[ \\\"$(#{left_command})\\\" == \\\"$(#{right_command})\\\" ]\""
    end

    met? {
      entries.all? do |entry|
        left_command = hash_entry(check_path(entry), target)
        right_command = (entry[:type] == 'hash-entry') ?
                          hash_entry(entry[:key_path], entry[:file]) :
                          hash_value(entry[:value])

        shell?(check_exists(check_path(entry), target)) &&
          shell?(check_equal(left_command, right_command))
      end
    }

    meet {
      entries.each do |entry|
        left_command = hash_entry(check_path(entry), target)
        right_command = (entry[:type] == 'hash-entry') ?
                          hash_entry(entry[:key_path], entry[:file]) :
                          hash_value(entry[:value])

        if entry[:type] == 'hash-entry'
          unless shell?(check_exists(check_path(entry), target)) &&
                 shell?(check_equal(left_command, right_command))
            shell(delete_entry(check_path(entry), target))
            shell(merge_entry(entry[:hash_path], entry[:file], target))
          end
        else
          shell(add_entry(entry[:path], entry[:type], target)) unless shell?(check_exists(entry[:path], target))
          shell(set_entry(entry[:path], entry[:value], target)) unless shell?(check_equal(left_command, right_command))
        end
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
