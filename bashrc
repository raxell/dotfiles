. ~/dotfiles/z/z.sh

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=2000
HISTFILESIZE=10000

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Assume support for 256 colors
export TERM=xterm-256color

# Prompt
function set_bash_prompt() {
    local BOLD_GREEN='\[\033[01;32m\]'
    local BOLD_BLUE='\[\033[01;34m\]'
    local BOLD_RED='\[\033[01;31m\]'
    local DEFAULT_TEXT='\[\033[00m\]'
    local GIT_BRANCH='$(git branch --format="%(HEAD) (%(refname:short))" 2> /dev/null | grep \* | cut -d"*" -f2)'

    echo "$BOLD_GREEN\u@\h$DEFAULT_TEXT $BOLD_BLUE\w$BOLD_RED$GIT_BRANCH$DEFAULT_TEXT\$ "
}

PS1=$(set_bash_prompt)

# Enable colors to distinguish file types
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias q='exit'

export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH=$HOME/bin:$PATH:/usr/lib/dart/bin:/usr/lib/dart/bin
export PATH="$PATH":"$HOME/.pub-cache/bin"

