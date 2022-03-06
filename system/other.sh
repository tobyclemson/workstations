#! /usr/bin/env bash

set -e
set -o pipefail

###############################################################################
# Other
###############################################################################

# Menu bar: hide the Time Machine
#defaults -currentHost write dontAutoLoad -array \
#    "/System/Library/CoreServices/Menu Extras/TimeMachine.menu"
#defaults write com.apple.systemuiserver menuExtras -array \
#    "/System/Library/CoreServices/Menu Extras/VPN.menu" \
#    "/System/Library/CoreServices/Menu Extras/Displays.menu" \
#    "/System/Library/CoreServices/Menu Extras/AirPort.menu"

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Increase opening and closing speed of Quick Look windows
defaults write NSGlobalDomain QLPanelAnimationDuration -float 0

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Disable animated focus ring
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

# Adjust toolbar title rollover delay
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Rubber-band scrolling (doesn't affect web views)
#defaults write NSGlobalDomain NSScrollViewRubberbanding -bool false

# Disable App Nap (not recommended)
#defaults write NSGlobalDomain NSAppSleepDisabled -bool true

# Disable the crash reporter
#defaults write com.apple.CrashReporter DialogType -string "none"

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Fix for the ancient UTF-8 bug in QuickLook (http://mths.be/bbo)
# Commented out, as this is known to cause problems in various Adobe apps :(
# See https://github.com/mathiasbynens/dotfiles/issues/237
#echo "0x08000100:0" > ~/.CFUserTextEncoding

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Connecting camera opens (path to application, or '' if no application)
defaults -currentHost write com.apple.ImageCapture2 HotPlugActionPath -string ''

# Link hidden applications
for app in /System/Library/CoreServices/Applications/* \
           /Applications/Xcode.app/Contents/Applications/* \
           /Applications/Xcode.app/Contents/Developer/Applications/*; do
  if [ ! -e "/Applications/Utilities/$(basename "$app")" ]; then
    sudo ln -s "$app" /Applications/Utilities/
  fi
done

# Link hidden preference panes
if [ ! -e '/Library/PreferencePanes/Archives.prefPane' ]; then
  sudo ln -s '/System/Library/CoreServices/Applications/Archive Utility.app/Contents/Resources/Archives.prefPane' \
             '/Library/PreferencePanes/Archives.prefPane'
fi

# Link hidden command line tools
if [ ! -L '/usr/local/bin/airport' ]; then
  sudo ln -s '/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport' \
             '/usr/local/bin/airport'
fi
if [ ! -L '/usr/local/bin/jsc' ]; then
  sudo ln -s '/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc' \
             '/usr/local/bin/jsc'
fi

# Link hidden fonts
if [ ! -e /Library/Fonts/CoreRecognition ]; then
  sudo ln -s /System/Library/PrivateFrameworks/CoreRecognition.framework/Resources/Fonts/ \
             /Library/Fonts/CoreRecognition
fi

# Disable Folder Actions
defaults write com.apple.FolderActionsDispatcher folderActionsEnabled -bool false

# Enable locate command and build locate database
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

###############################################################################
# Default Applications
#
# This is equivalent to the "Open with…" command in Finder.
# Default applications should be handled within each application's
# configuration using the `duti` package installed via Homebrew.
#
# The below outlines an alternative solution for configuring
# default applications.
###############################################################################

# defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers \
#   -array-add "{LSHandlerContentType=${content_type};LSHandlerRoleAll=${bundle_id};}"

if [ -x "/usr/local/bin/duti" ] && [ -d "${HOME}/.duti" ]; then
  /usr/local/bin/duti "${HOME}/.duti"
fi

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
  -kill -r \
  -domain local \
  -domain system \
  -domain user
