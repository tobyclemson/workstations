#! /usr/bin/env bash

set -e
set -o pipefail

###############################################################################
# Photos
###############################################################################

# Enable iCloud photos
defaults write com.apple.Photos IPXDefaultDidPromoteiCloudPhotosInGettingStarted -bool true
defaults write com.apple.Photos IPXDefaultHasBeenLaunched -bool true
defaults write com.apple.Photos IPXDefaultHasChosenToEnableiCloudPhotosInGettingStarted -int 1

# Summarize photos
# You can choose compact, summarized views for Collections and Years
defaults write com.apple.Photos IPXDefaultPhotosSummarizePhotos -bool true

# Copy items to the Photos library
# Only items copied to the library will upload to iCloud Photo library (when disabled)
defaults write com.apple.Photos IPXDefaultImportUseReferencedImport -bool false

# Include location information for published items
defaults write com.apple.Photos IPXDefaultPlacesPublishPlaceInfo -bool false

# Print Products Store
# Choose a store based on your billing address.
#defaults write com.apple.Photos KHStoreCountryExplicitlySetByUserKey -bool true
#defaults write com.apple.Photos KHUserPreferredStoreCountryKey -string 'UK'
