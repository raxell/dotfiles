export DOTFILES_DIR=$(dirname $0)

# Zsh Plugin Manager
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZPLUG_HOME="$HOME/.zplug"

if [ ! -d "$ZPLUG_HOME" ]; then
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

source "$ZPLUG_HOME/init.zsh"

# Quick jump between directories
zplug "rupa/z", use:z.sh
# Zsh prompt
zplug romkatv/powerlevel10k, as:theme, depth:1
# Yarn completion
zplug "g-plane/zsh-yarn-autocompletions", hook-build:"./zplug.zsh", defer:2

if ! zplug check; then
    zplug install
fi

zplug load


# Vi mode
bindkey -v
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

# Bind "^o" to "cd .."
function go_to_parent_dir {
    zle push-input
    cd ..
    zle send-break
}
zle -N go_to_parent_dir
bindkey '^o' go_to_parent_dir


HISTFILE="$HOME/.zsh_history"
# How many history entries keep in memory
HISTSIZE=2000
# How many history entries keep in the history file
SAVEHIST=999999999

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


export EDITOR=nvim


# Always run vim inside tmux
function vim() { tmux new "nvim $@" 2> /dev/null || nvim "$@"  }

# Aliases
alias tmx='tmux'
alias q='exit'


export FZF_DEFAULT_COMMAND='rg --files --hidden'


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f "$DOTFILES_DIR/.p10k.zsh" ]] || source "$DOTFILES_DIR/.p10k.zsh"
