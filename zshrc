# Zsh Plugin Manager
export ZPLUG_HOME="$HOME/.zplug"

if [ ! -d "$ZPLUG_HOME" ]; then
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

source "$ZPLUG_HOME/init.zsh"

# Quick jump between directories
zplug "rupa/z", use:z.sh
# Zsh prompt
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

zplug load


# Vi mode (enabled with spaceship-prompt function to make the mode indicator work)
spaceship_vi_mode_enable
# Make Vi mode transitions faster
export KEYTIMEOUT=20
# Map "jk" to ESC
bindkey -M viins 'jk' vi-cmd-mode

# Enable useful bindings in vi mode
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line


# Aliases
alias t='todo.sh -a'
alias q='exit'


HISTFILE="$HOME/.zsh_history"
# How many history entries keep in memory
HISTSIZE=2000
# How many history entries keep in the history file
SAVEHIST=10000

# Write the history file in the ':start:elapsed;command' format.
setopt EXTENDED_HISTORY
# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY
# Share history between all sessions.
setopt SHARE_HISTORY
# Do not record an event that was just recorded again.
setopt HIST_IGNORE_DUPS
# Do not display a previously found event.
setopt HIST_FIND_NO_DUPS
# Do not record an event starting with a space.
setopt HIST_IGNORE_SPACE
# Do not execute immediately upon history expansion.
setopt HIST_VERIFY
# append to history file
setopt APPEND_HISTORY
# Don't store history commands
setopt HIST_NO_STORE


SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_TIME_SHOW=true

