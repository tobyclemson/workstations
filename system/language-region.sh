#! /usr/bin/env bash

set -e
set -o pipefail

###############################################################################
# Language & Region
###############################################################################

# Preferred languages (in order of preference)
defaults write NSGlobalDomain AppleLanguages -array "en"

# Currency
# United States : `en_US@currency=USD`
# Great Britain : `en_GB@currency=EUR`
defaults write NSGlobalDomain AppleLocale -string "en_GB@currency=GBP"

# Measure Units
# `Inches` or `Centimeters`
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"

# Force 12/24 hour time
#defaults write NSGlobalDomain AppleICUForce12HourTime -bool true
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true

# Set Metric Units
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Show language menu in the top right corner of the boot screen
#sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true
