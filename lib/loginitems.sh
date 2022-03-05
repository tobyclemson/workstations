#! /usr/bin/env bash

set -e
set -o pipefail

function has-loginitem() {
  local name="$1"
  local found
  local script

  script="tell application \"System Events\" to get every login item"
  script="$script whose name is \"$name\""

  found=$(osascript -e "$script")

  echo "$found" | grep -q "$name"
}

function add-loginitem() {
  local name="$1"
  local path="$2"
  local hidden="${3:-false}"
  local script

  script="tell application \"System Events\" to make login item at end"
  script="$script with properties "
  script="$script {name:\"$name\", path:\"$path\", hidden:$hidden}"

  osascript -e "$script"
}

function ensure-loginitem() {
  local name="$1"
  local path="$2"
  local hidden="${3:-false}"

  if ! has-loginitem "$name"; then
    add-loginitem "$name" "$path" "$hidden"
  fi
}
