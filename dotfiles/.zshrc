export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="default"

plugins=(
  autojump
  aws
  brew
  bundler
  direnv
  docker
  emacs
  extract
  gem
  git
  github
  gradle
  jenv
  lein
  node
  npm
  nvm
  osx
  pip
  pyenv
  rake
  rbenv
  react-native
  rsync
  ruby
  sdk
  ssh-agent
  terraform
  tmux
  urltools
  virtualenv
  xcode
)

export PATH="$HOME/bin:/usr/local/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"
export EDITOR='vim'

export AUTHORS="@tobyclemson"

export NVM_HOMEBREW="/opt/homebrew/opt/nvm/"
export NVM_AUTOLOAD="1"

# ssh-add -K &> /dev/null
# ssh-add -A &> /dev/null

source $ZSH/oh-my-zsh.sh

echo -e "Kernel Information: " `uname -smr`
echo -e "`zsh --version`"
echo -ne "Uptime: "; uptime
echo -ne "Server time is: "; date

[[ $EMACS = t ]] && unsetopt zle

alias lla="ls -lah"
alias ber="nocorrect be rspec"

fpath=($HOME/.zsh-completions $fpath)
autoload -U compinit
compinit

export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"

export ANDROID_SDK="$HOME/Library/Android/sdk"
export ANDROID_HOME="$ANDROID_SDK"
export PATH="$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$PATH"

[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

eval "$(op signin my)"

for config_file ($HOME/.zshrc.d/*.zsh); do
  source $config_file
done
