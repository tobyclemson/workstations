#! /usr/bin/env bash

set -e
set -o pipefail

###############################################################################
# Desktop & Screen Saver
###############################################################################

# Set a custom wallpaper image. `DefaultDesktop.jpg` is already a symlink, and
# all wallpapers are in `/Library/Desktop Pictures/`. The default is `Wave.jpg`.
#rm -rf ~/Library/Application Support/Dock/desktoppicture.db
#sudo rm -rf /System/Library/CoreServices/DefaultDesktop.jpg
#sudo ln -s /path/to/your/image /System/Library/CoreServices/DefaultDesktop.jpg

# Start after being idle for time (in seconds)
defaults -currentHost write com.apple.screensaver idleTime -int 1800

# Disable screensaver clock
defaults -currentHost write com.apple.screensaver showClock -bool false
