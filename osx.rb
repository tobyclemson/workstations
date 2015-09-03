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

dep 'file extension vsibility.defaults' do
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

dep 'system preferences' do
  requires 'full disk encryption'
  requires 'full keyboard access.defaults'
  requires 'dock magnification.defaults'
  requires 'dock hiding.defaults'
  requires 'dock icons translucent for hidden applications.defaults'
  requires 'dock icon size.defaults'
  requires 'dashboard widgets.defaults'
  requires 'password on wake required.defaults'
  requires 'password on wake delay.defaults'
  requires 'network .DS_Store.defaults'
  requires 'key repeat rate.defaults'
  requires 'key repeat delay.defaults'
  requires 'expanded save panel.defaults'
  requires 'expanded print panel.defaults'
  requires 'no launch warnings.defaults'
  requires 'press and hold.defaults'
  requires 'auto-correct.defaults'
  requires 'smart quotes.defaults'
  requires 'smart dashes.defaults'
  requires 'window resize speed.defaults'
  requires 'screencapture location.defaults'
  requires 'quicklook copy.defaults'
  requires 'volume change feedback.defaults'
  requires 'full path in window titles.defaults'
  requires 'file extension change warning.defaults'
  requires 'trash security.defaults'
  requires 'trash empty warning.defaults'
  requires 'file extension vsibility.defaults'
  requires 'finder status bar.defaults'
  requires 'finder path bar.defaults'
  requires 'finder view.defaults'
  requires 'time machine autobackup.defaults'
  requires 'capslock to ctrl'
  requires 'system preferences'
  
  after {
    shell 'killall -HUP Dock'
    shell 'killall -HUP Finder'
    shell 'killall -HUP SystemUIServer'
  }
end
