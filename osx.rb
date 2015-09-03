dep 'full disk encryption' do
  met? {
    shell?("sudo fdesetup status").include? "On"
  }

  meet {
    shell("sudo fdesetup enable -user `whoami`")
  }
end

dep 'full keyboard access', :between, :template => 'plist', :for => :osx do
  def target
    current = Integer(fetch(domain, 'AppleKeyboardUIMode'))
    case between.to_s.to_sym
    when :textboxes_and_lists then current & 0xfd
    when :all_controls then current | 0x02
    else current
    end
  end

  domain 'NSGlobalDomain'
  values 'AppleKeyboardUIMode' => target
  types 'AppleKeyboardUIMode' => 'integer'
end

dep 'dock magnification' do
  met? {
    shell?("defaults read com.apple.dock magnification") &&
      shell("defaults read com.apple.dock magnification").to_i == 0
  }

  meet {
    shell("defaults write com.apple.dock magnification -integer 0")
    shell("killall -HUP Dock")
  }
end

dep 'dock hiding' do
  met? {
    shell?("defaults read com.apple.dock autohide") &&
      shell("defaults read com.apple.dock autohide") == "1"
  }

  meet {
    shell("defaults write com.apple.dock autohide -bool true")
    shell("killall -HUP Dock")
  }
end

dep 'dashboard widgets' do
  met? {
    cmd = "defaults read com.apple.dashboard mcx-disabled"
    shell?(cmd) &&
      shell(cmd).to_i == 1
  }

  meet {
    shell('defaults write com.apple.dashboard mcx-disabled -boolean YES')
    shell("killall -HUP Dock")
  }
end

dep 'capslock to ctrl' do
  def vendor_and_product_id
    keyboard_info = shell("ioreg -n IOHIDKeyboard -r")
    vendor_id = keyboard_info.scan(/"VendorID" = (\d+)/).flatten.first
    product_id = keyboard_info.scan(/"ProductID" = (\d+)/).flatten.first

    [vendor_id, product_id]
  end

  met? {
    vendor_id, product_id = vendor_and_product_id
    cmd = "defaults -currentHost read -g com.apple.keyboard.modifiermapping.#{vendor_id}-#{product_id}-0"
    shell?(cmd) && shell(cmd) ==
                   %Q{(
        {
        HIDKeyboardModifierMappingDst = 2;
        HIDKeyboardModifierMappingSrc = 0;
    }
)}
  }

  meet {
    vendor_id, product_id = vendor_and_product_id
    shell("defaults -currentHost write -g com.apple.keyboard.modifiermapping.#{vendor_id}-#{product_id}-0 -array '<dict><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer><key>HIDKeyboardModifierMappingDst</key><integer>2</integer></dict>'")
  }
end

dep 'password on wake', :required, :delay, :template => 'plist', :for => :osx do
  domain 'com.apple.screensaver'

  _values = {'askForPassword' => (required.current_value != false) ? 1 : 0}
  _values['askForPasswordDelay'] = Integer(delay.to_s) if delay.set?
  values _values

  types 'askForPassword' => 'int', 'askForPasswordDelay' => 'int'
end

dep 'network .DS_Store', :allow, :template => 'plist', :for => :osx do
  def value
    case allow.current_value
    when false, 'false' then false
    else true
    end
  end

  domain 'com.apple.desktopservices'
  values 'DSDontWriteNetworkStores' => !value
  checks 'DSDontWriteNetworkStores' => (value ? '0' : '1')
  types 'DSDontWriteNetworkStores' => 'boolean'
end

dep 'trash security', :mode, :template => 'plist', :for => :osx do
  mode.ask "Which mode should be used to empty trash"
  mode.choose %w[fast secure]
  mode.default "secure"

  # Retrieves the value to use for the setting
  def value
    case mode.to_s.to_sym
    when :fast then 'false'
    when :secure then 'true'
    end
  end

  domain 'com.apple.finder'
  values 'EmptyTrashSecurely' => value
  checks 'EmptyTrashSecurely' => (value == 'true' ? 1 : 0)
  types 'EmptyTrashSecurely' => 'boolean'
end

dep 'system preferences' do
  requires 'full keyboard access'.with(:all_controls)
  requires 'full disk encryption'
  requires 'dock magnification'
  requires 'dock hiding'
  requires 'dashboard widgets'
  requires 'capslock to ctrl'
  requires 'password on wake'.with(true, 5)
  requires 'network .DS_Store'.with(false)
  requires 'trash security'.with(:secure)

end
