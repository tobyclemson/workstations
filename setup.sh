#! /usr/bin/env bash

set -e
set -o pipefail

USER_NAME=${USER_NAME:-Toby Clemson}
USER_EMAIL=${USER_EMAIL:-tobyclemson@gmail.com}

# Install or update Homebrew
if ! which -s brew; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  brew update
fi

# Install all taps, brews, casks
brew bundle --verbose

# Fix some things
sudo xattr -r -d com.apple.quarantine /Applications/Emacs.app

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh/" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Setup oh-my-zsh
cp ./dotfiles/.zprofile ~
cp ./dotfiles/.zshrc ~
cp \
  ./dotfiles/.oh-my-zsh/custom/themes/default.zsh-theme \
  ~/.oh-my-zsh/custom/themes

# Setup git
if ! git config --global --get user.name | grep -q "$USER_NAME"; then
  git config --global user.name "$USER_NAME"
fi
if ! git config --global --get user.email | grep -q "$USER_EMAIL"; then
  git config --global user.email "$USER_EMAIL"
fi

# Setup karabiner
cp -R ./dotfiles/.config ~

# Setup jenv
for java in /Library/Java/JavaVirtualMachines/*; do
  jenv add "$java/Contents/Home"
done
