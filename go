#! /usr/bin/env bash

set -e
set -o pipefail
set -x

source ./lib/loginitems.sh

# atreyu, falkor, bastian, gmork, rockbiter

WORKSTATIONS_NAME=${WORKSTATIONS_NAME:-falkor}

WORKSTATIONS_USER_NAME=${WORKSTATIONS_USER_NAME:-Toby Clemson}
WORKSTATIONS_USER_EMAIL=${WORKSTATIONS_USER_EMAIL:-tobyclemson@gmail.com}

uname_machine="$(/usr/bin/uname -m)"
preference_files=()
affected_applications=()

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew prerequisites
softwareupdate --all --install --force
if [[ "$uname_machine" == "arm64" && ! -e /Library/Apple/usr/share/rosetta/rosetta ]]; then
  softwareupdate --install-rosetta --agree-to-license
fi

# Install or update Homebrew
if [[ "$uname_machine" == "arm64" ]]; then
  HOMEBREW_PREFIX="/opt/homebrew"
else
  HOMEBREW_PREFIX="/usr/local"
fi
if ! which -s brew; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
else
  brew update
fi

# Upgrade existing brews and casks
brew upgrade

# Install all taps, brews and casks
brew bundle --verbose --file Brewfile.common --no-lock

if [[ "${WORKSTATIONS_PERSONAL}" == "yes" ]]; then
  brew bundle --verbose --file Brewfile.personal --no-lock
fi

if [[ "${WORKSTATIONS_BABYLON}" == "yes" ]]; then
  brew bundle --verbose --file Brewfile.babylon --no-lock
fi

# Clean up
brew cleanup

# Un-quarantine casks
sudo xattr -r -d com.apple.quarantine /Applications/Emacs.app
sudo xattr -r -d com.apple.quarantine /Applications/QLMarkdown.app

# Reset Quicklook server
qlmanage -r

# Install SDKMAN!
if [ ! -e "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
  curl -s "https://get.sdkman.io" | bash
fi

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh/" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install prelude
if [ ! -d "$HOME/.emacs.d/" ]; then
  curl -L https://git.io/epre | sh
fi

# Copy initialisation dotfiles
cp -R ./dotfiles/.init ~

# Setup oh-my-zsh
cp ./dotfiles/.zprofile ~
cp ./dotfiles/.zshrc ~
cp \
  ./dotfiles/.oh-my-zsh/custom/themes/default.zsh-theme \
  ~/.oh-my-zsh/custom/themes

# Setup prelude
rm -rf ~/.emacs.d/personal
cp -R ./dotfiles/.emacs.d/personal ~/.emacs.d/

# Setup git
if [[ $(git config --global --get user.name) != *"$WORKSTATIONS_USER_NAME"* ]]; then
  git config --global user.name "$WORKSTATIONS_USER_NAME"
fi
if [[ $(git config --global --get user.email) != *"$WORKSTATIONS_USER_EMAIL"* ]]; then
  git config --global user.email "$WORKSTATIONS_USER_EMAIL"
fi

# Add loginitems
ensure-loginitem "Alfred 4" "/Applications/Alfred 4.app"
ensure-loginitem "SizeUp" "/Applications/SizeUp.app"
ensure-loginitem "Dropbox" "/Applications/Dropbox.app"
ensure-loginitem "Karabiner-Elements" "/Applications/Karabiner-Elements.app"
ensure-loginitem "1Password 7" "/Applications/1Password 7.app"

# Setup karabiner
cp -R ./dotfiles/.config ~

# Setup jenv
for java in /Library/Java/JavaVirtualMachines/*; do
  jenv add "$java/Contents/Home"
done

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e "tell application \"System Preferences\" to quit"

# Configure system and app preferences
function source_preferences {
  for file in "${preference_files[@]}"; do
    # shellcheck disable=SC1090
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
  done
}

function add_system_preferences {
  preference_files+=("system/$1.sh")
}

function add_application_preferences {
  preference_files+=("apps/$1.sh")
  shift
  affected_applications+=("$@")
}

function list_open_affected_applications {
  local open_applications=()

  # Store the open apps in an array
  for app in "${affected_applications[@]}"; do
    (( $(osascript -e "tell app \"System Events\" to count processes whose name is \"${app}\"") > 0 )) \
      && open_applications+=("$app")
  done

  echo "The following open applications will be affected:"
  printf -- '%s\n' "${open_applications[@]}" | column -x
}

function quit_applications {
  for app in "${affected_applications[@]}"; do
    case "$app" in
      'Quick Look')
        # Restart Quick Look
        qlmanage -r
        ;;
      *)
        killall "$app" &>/dev/null
        # osascript -e "tell application \"${app}\" to quit"
        ;;
    esac
  done
}

# Add system preferences
system_preferences=(
  general
  desktop-screen-saver
  dock
  mission-control
  language-region
  security-privacy
  spotlight
  notifications

  displays
  energy-saver
  keyboard
  # mouse
  trackpad
  printers-scanners
  sound
  # startup-disk

  icloud
  # internet-accounts
  extensions
  app-store
  network
  bluetooth
  sharing

  users-groups
  # parental-controls
  siri
  date-time
  time-machine
  accessibility

  other
  dashboard
  cds-dvds
  ssd
)

for preference_pane in "${system_preferences[@]}"; do
  add_system_preferences "$preference_pane"
done

for app in "cfprefsd" "SystemUIServer" "Dock" "SpeechSynthesisServer"; do
  affected_applications+=("$app")
done

# Add Apple application preferences
add_application_preferences "activity-monitor" "Activity Monitor"
add_application_preferences "app-store" "App Store"
add_application_preferences "calendar" "Calendar"
add_application_preferences "contacts" "Contacts"
add_application_preferences "disk-utility" "Disk Utility"
add_application_preferences "finder" "Finder"
add_application_preferences "font-book" "Font Book"
add_application_preferences "iwork" "Keynote" "Numbers" "Pages"
add_application_preferences "mail" "Mail"
add_application_preferences "messages" "Messages"
add_application_preferences "photos" "Photos"
add_application_preferences "quicktime" "QuickTime Player"
add_application_preferences "safari" "Safari" "WebKit"
add_application_preferences "screenshot"
add_application_preferences "terminal"
add_application_preferences "textedit" "TextEdit"

# Add 3rd party application preferences
add_application_preferences "adobe"
add_application_preferences "dropbox" "Dropbox"
add_application_preferences "google-chrome" "Google Chrome"
add_application_preferences "iterm2"
add_application_preferences "sizeup" "SizeUp"

# Source all preference scripts
list_open_affected_applications
source_preferences
quit_applications
