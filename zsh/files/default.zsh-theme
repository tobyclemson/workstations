autoload -U colors && colors

autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn

theme_precmd () {
		if [ $? -eq 0 ]; then CARETCOLOR="white"; else CARETCOLOR="red"; fi

    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats ' (%b%F{black})%c%u'
    } else {
        zstyle ':vcs_info:*' formats ' (%b%F{black})%c%u%F{red}●'
    }

    vcs_info
}

setopt prompt_subst

PROMPT='%F{blue}${PWD/#$HOME/~}%B%F{black}${vcs_info_msg_0_}%B%F{blue} %{${fg_bold[$CARETCOLOR]}%}→%{$reset_color%} '

autoload -U add-zsh-hook
add-zsh-hook precmd  theme_precmd
