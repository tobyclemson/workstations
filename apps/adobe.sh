#! /usr/bin/env bash

set -e
set -o pipefail

###############################################################################
# Adobe
###############################################################################

# Open Creative Cloud Installer app
#app_path="$(brew cask info adobe-creative-cloud | awk '$1~/^\// {print $1}')/Creative Cloud Installer.app"
#open -a "$app_path"

# Hide crufty Application folders
while IFS= read -r -d '' dir; do
  sudo chflags -v hidden "$dir"

  if [[ -e "${dir}/Configuration" ]]; then
    sudo chflags -v hidden "${dir}/Configuration"
  fi

  if [[ -e "${dir}/Resources" ]]; then
    sudo chflags -v hidden "${dir}/Resources"
  fi
done < <(find /Applications/ -maxdepth 1 -type d -name 'Adobe*' -print0)

while IFS= read -r -d '' dir; do
  sudo chflags -v hidden "$dir"
done < <(find /Applications/Utilities/ -maxdepth 1 -type d -name 'Adobe*' -print0)

# Remove Legal cruft
#rm -rf /Applications/Adobe*/Legal* 2>/dev/null

# Remove uninstaller aliases
#rm /Applications/Adobe*/Uninstall* 2>/dev/null