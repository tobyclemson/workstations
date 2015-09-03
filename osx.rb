dep 'full disk encryption', :for => :osx do
  met? {
    shell?('sudo fdesetup status').include? 'On'
  }

  meet {
    shell('sudo fdesetup enable -user `whoami`')
  }
end

dep 'full keyboard access.defaults', :for => :osx do
  domain 'NSGlobalDomain'
  key 'AppleKeyboardUIMode'
  value 3
end

dep 'dock magnification.defaults', :for => :osx do
  domain 'com.apple.dock'
  key 'magnification'
  value 0
end

dep 'dock hiding.defaults', :for => :osx do
  domain 'com.apple.dock'
  key 'autohide'
  value true
end

dep 'dock icons translucent for hidden applications.defaults' do
  domain 'com.apple.dock'
  key 'showhidden'
  value true
end

dep 'dock icon size.defaults' do
  domain 'com.apple.dock'
  key 'tilesize'
  value 38
end

dep 'dashboard widgets.defaults', :for => :osx do
  domain 'com.apple.dashboard'
  key 'mcx-disabled'
  value true
end

dep 'password on wake required.defaults', :for => :osx do
  domain 'com.apple.screensaver'
  key 'askForPassword'
  value 1
end

dep 'password on wake delay.defaults', :for => :osx do
  domain 'com.apple.screensaver'
  key 'askForPasswordDelay'
  value 0
end

dep 'network .DS_Store.defaults', :for => :osx do
  domain 'com.apple.desktopservices'
  key 'DSDontWriteNetworkStores'
  value true
end

dep 'key repeat rate.defaults' do
  domain 'NSGlobalDomain'
  key 'KeyRepeat'
  value 0
end

dep 'key repeat delay.defaults' do
  domain 'NSGlobalDomain'
  key 'InitialKeyRepeat'
  value 10
end

dep 'expanded save panel.defaults' do
  domain 'NSGlobalDomain'
  key 'NSNavPanelExpandedStateForSaveMode'
  value true
end

dep 'expanded print panel.defaults' do
  domain 'NSGlobalDomain'
  key 'PMPrintingExpandedStateForPrint'
  value true
end

dep 'no launch warnings.defaults' do
  domain 'com.apple.LaunchServices'
  key 'LSQuarantine'
  value false
end

dep 'press and hold.defaults' do
  domain 'NSGlobalDomain'
  key 'ApplePressAndHoldEnabled'
  value false
end

dep 'auto-correct.defaults' do
  domain 'NSGlobalDomain'
  key 'NSAutomaticSpellingCorrectionEnabled'
  value false
end

dep 'smart quotes.defaults' do
  domain 'NSGlobalDomain'
  key 'NSAutomaticQuoteSubstitutionEnabled'
  value false
end

dep 'smart dashes.defaults' do
  domain 'NSGlobalDomain'
  key 'NSAutomaticDashSubstitutionEnabled'
  value false
end

dep 'window resize speed.defaults' do
  domain 'NSGlobalDomain'
  key 'NSWindowResizeTime'
  value 0.001
end

dep 'screencapture location.defaults' do
  domain 'com.apple.screencapture'
  key 'location'
  value shell('cd ~/Pictures; pwd')
end

dep 'quicklook copy.defaults' do
  domain 'com.apple.finder'
  key 'QLEnableTextSelection'
  value true
end

dep 'volume change feedback.defaults' do
  domain 'NSGlobalDomain'
  key 'com.apple.sound.beep.feedback'
  value false
end

dep 'full path in window titles.defaults' do
  domain 'com.apple.finder'
  key '_FXShowPosixPathInTitle'
  value true
end

dep 'file extension change warning.defaults' do
  domain 'com.apple.finder'
  key 'FXEnableExtensionChangeWarning'
  value false
end

dep 'trash security.defaults', :for => :osx do
  domain 'com.apple.finder'
  key 'EmptyTrashSecurely'
  value true
end

dep 'trash empty warning.defaults' do
  domain 'com.apple.finder'
  key 'WarnOnEmptyTrash'
  value false
end

dep 'file extension visibility.defaults' do
  domain 'NSGlobalDomain'
  key 'AppleShowAllExtensions'
  value true
end

dep 'finder status bar.defaults' do
  domain 'com.apple.finder'
  key 'ShowStatusBar'
  value true
end

dep 'finder path bar.defaults' do
  domain 'com.apple.finder'
  key 'ShowPathbar'
  value true
end

dep 'finder view.defaults' do
  domain 'com.apple.finder'
  key 'FXPreferredViewStyle'
  value 'clmv'
end

dep 'time machine autobackup.defaults' do
  domain 'com.apple.TimeMachine'
  key 'AutoBackup'
  value false
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

dep "user library visibility" do
  met? {
    shell?("! ls -lO ~/ | grep -s 'Library' | grep -s 'hidden'")
  }

  meet {
    shell "chflags nohidden ~/Library"
  }
end

dep 'computer name', :computer_name, :local_hostname, :for => :osx do
  computer_name.ask("OS X Computer Name").default(shell('scutil --get ComputerName'))
  local_hostname.ask("OS X Local Hostname").default(computer_name.to_s.downcase.gsub(' ', '-'))
  
  met? {
    shell('scutil --get ComputerName') == computer_name &&
      shell('scutil --get HostName') == computer_name &&
      shell('scutil --get LocalHostName') == local_hostname &&
      shell('defaults read /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName') == local_hostname
  }
  meet {
    sudo "scutil --set ComputerName '#{computer_name}'"
    sudo "scutil --set HostName '#{computer_name}'"
    sudo "scutil --set LocalHostName '#{local_hostname}'"
    sudo "defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string '#{local_hostname}'"
  }
end

dep 'ac computer sleep delay.power', :for => :osx do
  type :ac
  property 'sleep'
  value '0'
end

dep 'ac display sleep delay.power', :for => :osx do
  type :ac
  property 'sleep'
  value '10'
end

dep 'ac disk sleep delay.power', :for => :osx do
  type :ac
  property 'sleep'
  value '10'
end

dep 'ac wake on network access.power', :for => :osx do
  type :ac
  property 'womp'
  value '1'
end

dep 'ac wake on lid open.power', :for => :osx do
  type :ac
  property 'lidwake'
  value '1'
end

dep 'battery computer sleep delay.power', :for => :osx do
  type :battery
  property 'sleep'
  value '10'
end

dep 'battery display sleep delay.power', :for => :osx do
  type :battery
  property 'sleep'
  value '5'
end

dep 'battery disk sleep delay.power', :for => :osx do
  type :battery
  property 'sleep'
  value '5'
end

dep 'battery wake on network access.power', :for => :osx do
  type :battery
  property 'womp'
  value '1'
end

dep 'battery wake on lid open.power', :for => :osx do
  type :battery
  property 'lidwake'
  value '1'
end

dep "power settings" do
  requires 'ac computer sleep delay.power'
  requires 'ac display sleep delay.power'
  requires 'ac disk sleep delay.power'
  requires 'ac wake on network access.power'
  requires 'ac wake on lid open.power'
  requires 'battery computer sleep delay.power'
  requires 'battery display sleep delay.power'
  requires 'battery disk sleep delay.power'
  requires 'battery wake on network access.power'
  requires 'battery wake on lid open.power'
end

dep 'osx settings' do
  requires 'full disk encryption'
  requires 'full keyboard access.defaults'
  requires 'key repeat rate.defaults'
  requires 'key repeat delay.defaults'
  requires 'expanded save panel.defaults'
  requires 'expanded print panel.defaults'
  requires 'press and hold.defaults'
  requires 'auto-correct.defaults'
  requires 'smart quotes.defaults'
  requires 'smart dashes.defaults'
  requires 'window resize speed.defaults'
  requires 'volume change feedback.defaults'
  requires 'file extension visibility.defaults'
  requires 'capslock to ctrl'
  requires 'user library visibility'
  requires 'password on wake required.defaults'
  requires 'password on wake delay.defaults'
  requires 'dashboard widgets.defaults'
  requires 'network .DS_Store.defaults'
  requires 'no launch warnings.defaults'
  requires 'screencapture location.defaults'
  requires 'time machine autobackup.defaults'

  after {
    shell 'killall -HUP Dock'
    shell 'killall -HUP SystemUIServer'
  }
end

dep 'finder settings' do
  requires 'full path in window titles.defaults'
  requires 'file extension change warning.defaults'
  requires 'trash security.defaults'
  requires 'trash empty warning.defaults'
  requires 'finder status bar.defaults'
  requires 'finder path bar.defaults'
  requires 'finder view.defaults'

  after {
    shell 'killall -HUP Finder'
  }
end

dep 'dock settings' do
  requires 'dock magnification.defaults'
  requires 'dock hiding.defaults'
  requires 'dock icons translucent for hidden applications.defaults'
  requires 'dock icon size.defaults'

  after {
    shell 'killall -HUP Dock'
  }
end

dep 'quicklook settings' do
  requires 'quicklook copy.defaults'
end

dep 'all settings' do
  requires 'osx settings'
  requires 'finder settings'
  requires 'dock settings'
  requires 'quicklook settings'
  requires 'power settings'
end
