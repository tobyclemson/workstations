#! /usr/bin/env bash

USER_NAME=${USER_NAME:-Toby Clemson}
USER_EMAIL=${USER_EMAIL:-tobyclemson@gmail.com}

# Install Homebrew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/tobyclemson/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install all taps, brews, casks
brew bundle

# Setup git
if ! git config --global --get user.name | grep -q "$USER_NAME"; then
  git config --global user.name "$USER_NAME"
fi
if ! git config --global --get user.email | grep -q "$USER_EMAIL"; then
  git config --global user.email "$USER_EMAIL"
fi

# Setup karabiner
cp -R ./dotfiles/.config ~
