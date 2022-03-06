#! /usr/bin/env bash

set -e
set -o pipefail

###############################################################################
# iCloud
###############################################################################

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
