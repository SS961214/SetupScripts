# Created by newuser for 5.8
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
	  eval "$(pyenv init -)"
fi

export LC_TIME=en_GB.UTF-8

source /etc/bashrc 2>/dev/null
export CC=gcc
export HISTFILE=${HOME}/.zhistory
export HISTSIZE=1000
export SAVEHIST=100000
export IGNOREEOF=1000

setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_expand
setopt inc_append_history
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "^u" backward-kill-line
bindkey "^w" kill-region

alias ls='ls -G --color=auto'
alias grep='grep --color=auto'
alias crontab='crontab -i'
alias python='python3'
alias pip='python3 -m pip'

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select #補完のリストの、選択している部分を塗りつぶす
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{cyan}"
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}"
zstyle ':vcs_info:git:*' formats '%u%c(%r)-[%b]%f' '%c%u %m'
zstyle ':vcs_info:git:*' actionformats '%u%c(%r)-[%b|%a]%f' '%c%u %m'

# prompt
precmd () {
  Date=$(date "+%Y/%m/%d")
  PROMPT="%F{%(?.cyan.red)}$Date %* %d%f"
  PROMPT+="
  %(?..%F{red})%n@%m %(?..(%?%)%f)%# "
}
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT='${vcs_info_msg_0_}'

export PATH=/usr/local/bin:$PATH

if [ -e "/opt/intel/oneapi/setvars.sh" ]; then
  source /opt/intel/oneapi/setvars.sh --force
fi

echo "# >>> conda initialize >>>"
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/shoki/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"

if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/shoki/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/shoki/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/shoki/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
