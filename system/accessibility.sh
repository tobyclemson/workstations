#! /usr/bin/env bash

set -e
set -o pipefail

###############################################################################
# Accessibility
###############################################################################

# Enable access for assistive devices
echo -n 'a' | sudo tee /private/var/db/.AccessibilityAPIEnabled &>/dev/null
sudo chmod 444 /private/var/db/.AccessibilityAPIEnabled
# TODO: avoid GUI password prompt somehow (http://apple.stackexchange.com/q/60476/4408)
#sudo osascript -e 'tell application "System Events" to set UI elements enabled to true'

## Display

# Disable increased contrast
sudo defaults write com.apple.universalaccess increaseContrast -bool false

# Disable reduced transparency
sudo defaults write com.apple.universalaccess reduceTransparency -bool false

# Disable shake mouse cursor to locate
defaults write CGDisableCursorLocationMagnification -bool false

## Zoom

# Disable temporary zoom (Hold down ⌃⌥ to zoom when needed)
sudo defaults write com.apple.universalaccess closeViewPressOnReleaseOff -bool false

# Zoom using scroll gesture with the Ctrl (^) modifier key
sudo defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
sudo defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# Disable zoomed image smoothing
sudo defaults write com.apple.universalaccess closeViewSmoothImages -bool false

# Follow the keyboard focus while zoomed
sudo defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# Zoom Style
# 0 : Fullscreen
# 1 : Picture-in-picture
sudo defaults write com.apple.universalaccess closeViewZoomMode -int 1

## Speech

# Enable text to speech
defaults write com.apple.speech.synthesis.general.prefs SpokenUIUseSpeakingHotKeyFlag -bool true

# Speak selected text when the key is pressed
# Option+Esc : 2101
defaults write com.apple.speech.synthesis.general.prefs SpokenUIUseSpeakingHotKeyCombo -int 2101

# System Voice
# Creator    | ID  | Name
# -----------+-----+------
# 1835364215 | 201 | Alex
# 1734437985 | 100 | Bruce
defaults write com.apple.speech.voice.prefs VisibleIdentifiers \
  '{ "com.apple.speech.synthesis.voice.Alex" = 1; }'
defaults write com.apple.speech.voice.prefs SelectedVoiceCreator -int 1835364215
defaults write com.apple.speech.voice.prefs SelectedVoiceID -int 201
defaults write com.apple.speech.voice.prefs SelectedVoiceName -string "Alex"

# Speaking Rate
# Set as a multidimensional array:
#   The 1st value is the SelectedVoiceCreator
#   The 2nd value is the SelectedVoiceID
#   The 3rd value is the speaking rate
# Slow   : 90
# Normal : 175
# Fast   : 350
plutil -replace VoiceRateDataArray -json '[
  [
    1835364215,
    201,
    350
  ]
]' ~/Library/Preferences/com.apple.speech.voice.prefs.plist
