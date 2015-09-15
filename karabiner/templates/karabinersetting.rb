meta 'karabinersetting' do
  accepts_value_for :setting
  accepts_value_for :value

  template {
    requires 'karabiner.cask'

    karabiner = '/Applications/Karabiner.app/Contents/Library/bin/karabiner'

    met? {
      shell("#{karabiner} changed | grep #{setting} | cut -d '=' -f 2") == "#{value}"
    }

    meet {
      shell("#{karabiner} set #{setting} #{value}")
    }
  }
end
