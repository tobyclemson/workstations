#! /usr/bin/env bash

set -e
set -o pipefail

###############################################################################
# Dropbox
###############################################################################

# Remove Dropbox’s green checkmark icons in Finder
#dropbox_icns=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
#[ -e "$dropbox_icns" ] && mv -f "$dropbox_icns" "$dropbox_icns.bak"
