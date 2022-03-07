#! /usr/bin/env bash

set -e
set -o pipefail

###############################################################################
# iTerm 2                                                                     #
###############################################################################

# Install the IR_Black theme for iTerm
open "${HOME}/.init/IR_Black.itermcolors"

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
