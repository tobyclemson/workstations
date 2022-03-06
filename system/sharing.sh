#! /usr/bin/env bash

set -e
set -o pipefail

###############################################################################
# Sharing
###############################################################################

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "${WORKSTATIONS_NAME}"
sudo scutil --set HostName "${WORKSTATIONS_NAME}"
sudo scutil --set LocalHostName "${WORKSTATIONS_NAME}"
sudo defaults write \
  /Library/Preferences/SystemConfiguration/com.apple.smb.server \
  NetBIOSName \
  -string "${WORKSTATIONS_NAME}"
