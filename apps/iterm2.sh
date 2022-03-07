#! /usr/bin/env bash

set -e
set -o pipefail

###############################################################################
# iTerm 2                                                                     #
###############################################################################

# Install the IR_Black theme for iTerm
if ! defaults read com.googlecode.iterm2 "Custom Color Presets" | grep -q "IR_Black"; then
  open "${HOME}/.init/IR_Black.itermcolors"
fi

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
