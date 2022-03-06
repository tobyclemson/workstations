#! /usr/bin/env bash

set -e
set -o pipefail

###############################################################################
# Font Book
###############################################################################

# Use Repertoire preview type and mode
# Preview type and mode
# 0 : Custom
# 1 : Repertoire
# 2 : Sample
# 3 : Font Info
defaults write com.apple.FontBook FBPreviewTypeKey -int 1
defaults write com.apple.FontBook FBPreviewModeKey -int 1

# Resolve duplicates by moving files to the trash
defaults write com.apple.FontBook FBResolveByMovingToTrashKey -bool true

# Set default sample font size
defaults write com.apple.FontBook FBSampleSize -int 18

# Install for user only by default
# Default Install Location
# 1 : Computer
# 3 : User
defaults write com.apple.FontBook FBDefaultInstallDomainRef -int 3

# Set font sample text
defaults write com.apple.FontBook FBComparisonViewText -string 'The quick brown fox jumps over the lazy dog.'
defaults write com.apple.FontBook FBCustomSampleString -string 'The quick brown fox jumps over the lazy dog.'

# Activate fonts automatically
#defaults write com.apple.ATS ATSAutoActivation -string "ATSAutoActivationEnable"
