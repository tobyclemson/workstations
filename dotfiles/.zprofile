UNAME_MACHINE="$(/usr/bin/uname -m)"
if [[ "$UNAME_MACHINE" == "arm64" ]]; then
  HOMEBREW_PREFIX="/opt/homebrew"
else
  HOMEBREW_PREFIX="/usr/local"
fi

eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
