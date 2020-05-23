* Add fish to /etc/shells
* Login items for google drive, flux
* Change spotlight keyboard shortcuts
* Set items in dock
* IntelliJ license
* IntelliJ plugins
* Cursive license
* Sketch license
* Investigate problem with brews not installing
* Add lock button to touch bar
* Increase mouse tracking speed
* Automatically mark certain apps as unquarantined (e.g., Caffeine),
  via `xattr -dr com.apple.quarantine "unidentified_thirdparty.app"`
* Allow kernel extensions for certain team IDs, 
  e.g., for karabiner and virtualbox, via spctl.
* Change spotlight shortcuts to ^-SPACE and ^-OPT-SPACE via
  com.apple.symbolichotkeys.plist
* Set hostname via
  sudo scutil --set HostName <new host name>
  sudo scutil --set LocalHostName <new host name>
  sudo scutil --set ComputerName <new name>
  dscacheutil -flushcache