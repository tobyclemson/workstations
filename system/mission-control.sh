#! /usr/bin/env bash

set -e
set -o pipefail

###############################################################################
# Mission Control
###############################################################################

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# When switching to an application, switch to a Space with open windows for the
# application
defaults write NSGlobalDomain AppleSpacesSwitchOnActivate -bool true

# Don't group windows by application in Mission Control
# (i.e., use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -bool false

# Displays have separate Spaces
defaults write com.apple.spaces spans-displays -bool false

# Disable the Launchpad gesture (pinch with thumb and three fingers)
#defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

# Reset Launchpad
#find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

# Add iOS Simulator to Launchpad
#if [ -e "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" ]; then
#    sudo ln -sf \
#      "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" \
#      "/Applications/Simulator.app"
#fi

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
# Top left screen corner → Mission Control
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Show application windows
defaults write com.apple.dock wvous-tr-corner -int 3
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom right screen corner → Desktop
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0
# Bottom left screen corner → Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 13
defaults write com.apple.dock wvous-bl-modifier -int 0
