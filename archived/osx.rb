dep 'full disk encryption', :for => :osx do
  met? {
    shell?('fdesetup status').include? 'On'
  }

  meet {
    shell('sudo fdesetup enable -user `whoami`')
  }
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

dep 'menuitems.defaults', :for => :osx do
  domain 'com.apple.systemuiserver'
  key 'menuExtras'
  values [
    "/Applications/Utilities/Keychain Access.app/Contents/Resources/Keychain.menu",
    "/System/Library/CoreServices/Menu Extras/TimeMachine.menu",
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu",
    "/System/Library/CoreServices/Menu Extras/Volume.menu",
    "/System/Library/CoreServices/Menu Extras/AirPort.menu",
    "/System/Library/CoreServices/Menu Extras/Battery.menu",
    "/System/Library/CoreServices/Menu Extras/Clock.menu"
  ]
end

dep "menuitem settings" do
  requires 'menuitems.defaults'

  after {
    shell 'killall -HUP SystemUIServer'
  }
end

dep 'quicklook settings' do
  requires 'quicklook copy.defaults'
end
