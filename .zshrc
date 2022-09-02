# Created by newuser for 5.8
export LC_TIME=en_GB.UTF-8
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
zstyle ':completion:*' menu select

# <<< Get information from a version control system: git
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{cyan}"
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}"
zstyle ':vcs_info:git:*' formats '%u%c(%r)-[%b]%f' '%c%u %m'
zstyle ':vcs_info:git:*' actionformats '%u%c(%r)-[%b|%a]%f' '%c%u %m'
# >>> Get information from a version control system: git

# <<< prompt
precmd () {
  Date=$(date "+%Y/%m/%d")
  PROMPT="%(?.%F{cyan}.%F{red})$Date %* %d%f"
  PROMPT+="
  %(?..%F{red})%n@%m %(?..(%?%)%f)%# "
}
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT='${vcs_info_msg_0_}'
# >>> prompt

if [ -e "/usr/local/bin" ] && [ ! `echo $PATH | grep /usr/local/bin` ]; then
	export PATH=/usr/local/bin:$PATH
fi
if [ -e "/opt/intel/oneapi/setvars.sh" ] && [ -z "$MKLROOT" ]; then
  source /opt/intel/oneapi/setvars.sh --force
fi

exist () {
	if [ `which $1` ]; then
		echo `which $1`;
		return 0;
	else
		return 1;
	fi
}
