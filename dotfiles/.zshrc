export ZSH=$HOME/.oh-my-zsh

plugins=(
  autojump
  aws
  brew
  bundler
  colored-man-pages
  colorize
  command-not-found
  direnv
  docker
  emacs
  extract
  gem
  git
  github
  gnu-utils
  gpg-agent
  gradle
  history
  jenv
  keychain
  lein
  macos
  node
  npm
  nvm
  pip
  pyenv
  python
  rake
  rbenv
  react-native
  rsync
  ruby
  sdk
  ssh-agent
  terraform
  urltools
  virtualenv
  web-search
  xcode
)

zstyle ':omz:update' frequency 7
zstyle ':omz:plugins:keychain' agents 'gpg,ssh'

mkdir -p "$HOME/.ssh"
keys=($(find "$HOME/.ssh" -name 'id*' | grep -v ".pub"))
zstyle ':omz:plugins:ssh-agent' identities $keys

export PATH="$HOME/bin:$PATH"

export MANPATH="/usr/local/man:$MANPATH"
export EDITOR='vim'

export AUTHORS="@tobyclemson"

export NVM_HOMEBREW="$HOMEBREW_PREFIX/opt/nvm/"
export NVM_AUTOLOAD="1"

export CLOUDSDK_HOME="$HOMEBREW_PREFIX/share/google-cloud-sdk/"

export ZSH_COLORIZE_CHROMA_FORMATTER="terminal256"
export ZSH_COLORIZE_STYLE="monokai"

export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

source $ZSH/oh-my-zsh.sh

CPATH="$HOMEBREW_PREFIX/include"
LIBRARY_PATH="$HOMEBREW_PREFIX/lib"

LDFLAGS="$LDFLAGS -L$HOMEBREW_PREFIX/opt/bzip2/lib"
LDFLAGS="$LDFLAGS -L$HOMEBREW_PREFIX/opt/gcc/lib"
LDFLAGS="$LDFLAGS -L$HOMEBREW_PREFIX/opt/gettext/lib"
LDFLAGS="$LDFLAGS -L$HOMEBREW_PREFIX/opt/icu4c/lib"
LDFLAGS="$LDFLAGS -L$HOMEBREW_PREFIX/opt/imap-uw/lib"
LDFLAGS="$LDFLAGS -L$HOMEBREW_PREFIX/opt/libedit/lib"
LDFLAGS="$LDFLAGS -L$HOMEBREW_PREFIX/opt/openldap/lib"
LDFLAGS="$LDFLAGS -L$HOMEBREW_PREFIX/opt/openssl@1.1/lib"
LDFLAGS="$LDFLAGS -L$HOMEBREW_PREFIX/opt/tidy-html5/lib"
LDFLAGS="$LDFLAGS -L$HOMEBREW_PREFIX/opt/zlib/lib"

CPPFLAGS="$CPPFLAGS -I$HOMEBREW_PREFIX/opt/bzip2/include"
CPPFLAGS="$CPPFLAGS -I$HOMEBREW_PREFIX/opt/gcc/include"
CPPFLAGS="$CPPFLAGS -I$HOMEBREW_PREFIX/opt/gettext/include"
CPPFLAGS="$CPPFLAGS -I$HOMEBREW_PREFIX/opt/icu4c/include"
CPPFLAGS="$CPPFLAGS -I$HOMEBREW_PREFIX/opt/imap-uw/include"
CPPFLAGS="$CPPFLAGS -I$HOMEBREW_PREFIX/opt/libedit/include"
CPPFLAGS="$CPPFLAGS -I$HOMEBREW_PREFIX/opt/openldap/include"
CPPFLAGS="$CPPFLAGS -I$HOMEBREW_PREFIX/opt/openssl@1.1/include"
CPPFLAGS="$CPPFLAGS -I$HOMEBREW_PREFIX/opt/tidy-html5/include"
CPPFLAGS="$CPPFLAGS -I$HOMEBREW_PREFIX/opt/zlib/include"

PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$HOMEBREW_PREFIX/opt/icu4c/lib/pkgconfig"
PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$HOMEBREW_PREFIX/opt/libedit/lib/pkgconfig"
PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$HOMEBREW_PREFIX/opt/openldap/lib/pkgconfig"
PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$HOMEBREW_PREFIX/opt/openssl@1.1/lib/pkgconfig"
PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$HOMEBREW_PREFIX/opt/tidy-html5/lib/pkgconfig"
PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$HOMEBREW_PREFIX/opt/zlib/lib/pkgconfig"

export LDFLAGS
export CPPFLAGS
export PKG_CONFIG_PATH
export CPATH
export LIBRARY_PATH

eval "$(starship init zsh)"

echo -e "Kernel Information: " `uname -smr`
echo -e "`zsh --version`"
echo -ne "Uptime: "; uptime
echo -ne "Server time is: "; date

[[ $EMACS = t ]] && unsetopt zle

fpath=($HOME/.zsh-completions $fpath)
autoload -U compinit
compinit

# export GOENV_ROOT="$HOME/.goenv"
# export PATH="$GOENV_ROOT/bin:$PATH"
# eval "$(goenv init -)"

export ANDROID_SDK="$HOME/Library/Android/sdk"
export ANDROID_HOME="$ANDROID_SDK"
export PATH="$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$PATH"

export PATH="$HOMEBREW_PREFIX/opt/gnupg@2.2/bin:$PATH"

[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

source "$HOME/.sdkman/bin/sdkman-init.sh"

for file ($HOME/.{aliases,functions,workstation}); do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

if [[ -d "$HOME/.zshrc.d" && "$(ls -A $HOME/.zshrc.d/)" ]]; then
  for file ($HOME/.zshrc.d/*.zsh); do
    source "$file"
  done
fi
