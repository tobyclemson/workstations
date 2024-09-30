#! /usr/bin/env bash

[ "$TRACE" = "yes" ] && set -x
set -e
set -o pipefail

source ./lib/loginitems.sh

# atreyu, falkor, bastian, gmork, rockbiter

WORKSTATIONS_NAME=${WORKSTATIONS_NAME:-falkor}

WORKSTATIONS_RUN_SOFTWARE_UPDATE=${WORKSTATIONS_RUN_SOFTWARE_UPDATE:-yes}
WORKSTATIONS_CONFIGURE_SYSTEM=${WORKSTATIONS_CONFIGURE_SYSTEM:-yes}
WORKSTATIONS_CONFIGURE_APPS=${WORKSTATIONS_CONFIGURE_APPS:-yes}

WORKSTATIONS_PERSONAL=${WORKSTATIONS_PERSONAL:-yes}
WORKSTATIONS_EBURY=${WORKSTATIONS_EBURY:-yes}

WORKSTATIONS_USER_NAME=${WORKSTATIONS_USER_NAME:-"Toby Clemson"}
WORKSTATIONS_USER_EMAIL=${WORKSTATIONS_USER_EMAIL:-tobyclemson@gmail.com}

uname_machine="$(/usr/bin/uname -m)"
preference_files=()
affected_applications=()

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 10; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew prerequisites
if [[ "$WORKSTATIONS_RUN_SOFTWARE_UPDATE" != "no" ]]; then
  softwareupdate --all --install --force
  if [[ "$uname_machine" == "arm64" && ! -e /Library/Apple/usr/share/rosetta/rosetta ]]; then
    softwareupdate --install-rosetta --agree-to-license
  fi
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

# Clean up before subsequent steps set up ZSH
rm -rf ~/.zshrc.d

# Perform optional personal workstation setup
if [[ "${WORKSTATIONS_PERSONAL}" == "yes" ]]; then
  ./go_personal
fi

# Perform optional context specific workstation setup
if [[ "${WORKSTATIONS_PERSONAL}" == "yes" ]]; then
  ./go_personal
fi
if [[ "${WORKSTATIONS_EBURY}" == "yes" ]]; then
  ./go_ebury
fi

# Setup docker
mkdir -p ~/.docker/cli-plugins
cp ./dotfiles/.docker/config.json ~/.docker/config.json
ln -sfn "$HOMEBREW_PREFIX/opt/docker-buildx/bin/docker-buildx" ~/.docker/cli-plugins/docker-buildx
ln -sfn "$HOMEBREW_PREFIX/opt/docker-compose/bin/docker-compose" ~/.docker/cli-plugins/docker-compose
if ! brew services list | grep started | grep colima; then
  brew services start colima
fi

# Clean up
brew cleanup

# Un-quarantine casks
# sudo xattr -r -d com.apple.quarantine /Applications/Emacs.app
sudo xattr -r -d com.apple.quarantine /Applications/QLMarkdown.app
sudo xattr -r -d com.apple.quarantine /Applications/Spotify.app

# Reset Quicklook server
qlmanage -r

# Install asdf plugins
function ensure-asdf-plugin() {
  local name="$1"
  local repo="$2"

  if ! asdf plugin list | grep -q "$name"; then
    asdf plugin add "$name" "$repo"
  fi
}

ensure-asdf-plugin "ruby" "https://github.com/asdf-vm/asdf-ruby.git"
ensure-asdf-plugin "java" "https://github.com/halcyon/asdf-java.git"
ensure-asdf-plugin "python" "https://github.com/asdf-community/asdf-python.git"
ensure-asdf-plugin "pipenv" "https://github.com/and-semakin/asdf-pipenv.git"
ensure-asdf-plugin "poetry" "https://github.com/asdf-community/asdf-poetry.git"
ensure-asdf-plugin "php" "https://github.com/asdf-community/asdf-php.git"
ensure-asdf-plugin "nodejs" "https://github.com/asdf-vm/asdf-nodejs.git"
ensure-asdf-plugin "haskell" "https://github.com/vic/asdf-haskell.git"
ensure-asdf-plugin "golang" "https://github.com/asdf-community/asdf-golang.git"
ensure-asdf-plugin "babashka" "https://github.com/pitch-io/asdf-babashka"
ensure-asdf-plugin "cocoapods" "https://github.com/ronnnnn/asdf-cocoapods.git"
ensure-asdf-plugin "flutter" "https://github.com/asdf-community/asdf-flutter.git"
ensure-asdf-plugin "dart" "https://github.com/patoconnor43/asdf-dart.git"
ensure-asdf-plugin "firebase" "https://github.com/jthegedus/asdf-firebase.git"
ensure-asdf-plugin "conan" "https://github.com/amrox/asdf-pyapp.git"
ensure-asdf-plugin "cmake" "https://github.com/asdf-community/asdf-cmake.git"

# ZSH Go integration requires at least one asdf managed version of Go
asdf install golang 1.22.0
asdf global golang 1.22.0

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh/" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install prelude
if [ ! -d "$HOME/.emacs.d/" ]; then
  curl -L https://git.io/epre | sh
fi

# Copy SSH config
mkdir -p ~/.ssh
cp ./dotfiles/.ssh/config ~/.ssh

# Copy initialisation dotfiles
cp -R ./dotfiles/.init ~

# Setup oh-my-zsh
cp ./dotfiles/.aliases ~
cp ./dotfiles/.functions ~
cp ./dotfiles/.zprofile ~
cp ./dotfiles/.zshrc ~

mkdir -p ~/.zshrc.d
cp -R ./dotfiles/.zshrc.d/common/* ~/.zshrc.d/

mkdir -p ~/.zsh-completions
poetry completions zsh > ~/.zsh-completions/_poetry

# Store workstation environment variables
if [[ -f "$HOME/.workstation" ]]; then
  rm "$HOME/.workstation"
fi
for var in "${!WORKSTATIONS_@}"; do
  printf 'export %s="%s"\n' "$var" "${!var}" >> "$HOME/.workstation"
done

# Setup prelude
rm -rf ~/.emacs.d/personal
cp -R ./dotfiles/.emacs.d/personal ~/.emacs.d/

# Setup git
cp ./dotfiles/.gitconfig ~
if [[ $(git config --global --get user.name) != *"$WORKSTATIONS_USER_NAME"* ]]; then
  git config --global user.name "$WORKSTATIONS_USER_NAME"
fi
if [[ $(git config --global --get user.email) != *"$WORKSTATIONS_USER_EMAIL"* ]]; then
  git config --global user.email "$WORKSTATIONS_USER_EMAIL"
fi

# Add loginitems
ensure-loginitem "Dropbox" "/Applications/Dropbox.app"
ensure-loginitem "Karabiner-Elements" "/Applications/Karabiner-Elements.app"
ensure-loginitem "Alfred 4" "/Applications/Alfred 4.app"
ensure-loginitem "SizeUp" "/Applications/SizeUp.app"
ensure-loginitem "1Password 7" "/Applications/1Password 7.app"
ensure-loginitem "Bartender 4" "/Applications/Bartender 4.app"

# Add tool specific config files
cp -R ./dotfiles/.config ~

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e "tell application \"System Preferences\" to quit"

# Configure system and app preferences
source_preferences () {
  for file in "${preference_files[@]}"; do
    # shellcheck disable=SC1090
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
  done
}

add_system_preferences () {
  preference_files+=("system/$1.sh")
}

add_application_preferences () {
  preference_files+=("apps/$1.sh")
  shift
  affected_applications+=("$@")
}

list_open_affected_applications () {
  local open_applications=()

  # Store the open apps in an array
  for app in "${affected_applications[@]}"; do
    (( $(osascript -e "tell app \"System Events\" to count processes whose name is \"${app}\"") > 0 )) \
      && open_applications+=("$app")
  done

  echo "The following open applications will be affected:"
  printf -- '%s\n' "${open_applications[@]}" | column -x
}

quit_applications () {
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
if [[ "$WORKSTATIONS_CONFIGURE_SYSTEM" != "no" ]]; then
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
fi

if [[ "$WORKSTATIONS_CONFIGURE_APPS" != "no" ]]; then
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
fi