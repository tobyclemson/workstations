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

    def entry_checksum path, target, as_xml: false
      "#{plistbuddy} #{as_xml ? '-x ' : ''}-c \"Print #{path}\" \"#{resolve(target)}\" | md5"
    end

    def value_checksum value
      "echo '#{value}' | md5"
    end

    def check_exists path, target
      "#{plistbuddy} -c \"Print #{path}\" \"#{resolve(target)}\" 2>&1 | grep -vq 'Does Not Exist'"
    end

    def check_equal left, right
      "bash -c \"[ \\\"$(#{left})\\\" == \\\"$(#{right})\\\" ]\""
    end

    def is_hash_entry entry
      (entry[:type] == 'hash-entry')
    end

    def actual_path_for entry
       is_hash_entry(entry) ?
        "#{entry[:hash_path]}#{entry[:key_path]}" :
        entry[:path]
    end

    def actual_checksum_for entry
      is_hash_entry(entry) ?
        entry_checksum(actual_path_for(entry), target, as_xml: true) :
        entry_checksum(actual_path_for(entry), target, as_xml: false)
    end

    def expected_checksum_for entry
      is_hash_entry(entry) ?
        entry_checksum(entry[:key_path], entry[:file], as_xml: true) :
        value_checksum(entry[:value])
    end

    met? {
      entries.all? do |entry|
        shell?(check_exists(actual_path_for(entry), target)) &&
          shell?(check_equal(actual_checksum_for(entry), expected_checksum_for(entry)))
      end
    }

    meet {
      entries.each do |entry|
        if is_hash_entry(entry)
          unless shell?(check_exists(actual_path_for(entry), target)) &&
                 shell?(check_equal(actual_checksum_for(entry), expected_checksum_for(entry)))
            shell(delete_entry(actual_path_for(entry), target)) if shell?(check_exists(actual_path_for(entry), target))
            shell(merge_entry(entry[:hash_path], entry[:file], target))
          end
        else
          unless shell?(check_exists(entry[:path], target))
            shell(add_entry(entry[:path], entry[:type], target))
          end
          unless shell?(check_equal(actual_checksum_for(entry), expected_checksum_for(entry)))
            shell(set_entry(entry[:path], entry[:value], target))
          end
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
