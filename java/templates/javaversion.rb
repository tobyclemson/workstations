meta :javaversion do
  accepts_value_for :path

  template {
    met? {
      shell("osascript -e 'tell application \"System Events\" to get every login item whose name is \"#{name}\"'") =~ /#{name}/
    }

    meet {
      shell("osascript -e 'tell application \"System Events\" to make login item at end with properties {path:\"#{path}\", hidden:#{hidden}, name:\"#{name}\"}'")
    }
  }
end
