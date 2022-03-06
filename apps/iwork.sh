#! /usr/bin/env bash

set -e
set -o pipefail

###############################################################################
# iWork
###############################################################################

## Keynote

# Don't show first run stuff
#defaults write com.apple.iWork.Keynote 'ShowStartingPointsForNewDocument' -bool false
defaults write com.apple.iWork.Keynote 'dontShowWhatsNew' -bool true
defaults write com.apple.iWork.Keynote 'FirstRunFlag' -bool true

## Numbers

# Don't show first run stuff
#defaults write com.apple.iWork.Numbers 'ShowStartingPointsForNewDocument' -bool false
defaults write com.apple.iWork.Numbers 'dontShowWhatsNew' -bool true
defaults write com.apple.iWork.Numbers 'FirstRunFlag' -bool true

# Add hotkey for "File > Export To > CSV…"
defaults write com.apple.iWork.Numbers NSUserKeyEquivalents -dict-add "\033File\033Export To\033CSV…" '^~@s'

## Pages

# Don't show first run stuff
#defaults write com.apple.iWork.Pages 'ShowStartingPointsForNewDocument' -bool false
defaults write com.apple.iWork.Pages 'dontShowWhatsNew' -bool true
defaults write com.apple.iWork.Pages 'FirstRunFlag' -bool true