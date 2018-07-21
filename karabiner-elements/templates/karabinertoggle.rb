meta :karabinertoggle do
  accepts_value_for :setting
  accepts_value_for :enabled

  template {
    requires 'karabiner.cask'

    def toggle_value
      enabled ? '1' : '0'
    end

    def command
      enabled ? 'enable' : 'disable'
    end

    karabiner = '/Applications/Karabiner.app/Contents/Library/bin/karabiner'

    met? {
      shell("#{karabiner} changed | grep #{setting} | cut -d '=' -f 2") == "#{toggle_value}"
    }

    meet {
      shell("#{karabiner} #{command} #{setting}")
    }
  }
end
