#!/bin/bash

DOTFILES_DIR=$(cd `dirname $0` && pwd)

if [ -z "$ME" ]; then
    echo "Missing environment variable ME"
    exit 1
fi

if [ $USER != $ME ]; then
    echo "Cannot setup environment: ME does not match the current user"
    echo "ME=$ME"
    echo "USER=$USER"
    exit 1
fi


echo
echo "THIS SCRIPT WILL OVERRIDE YOUR CONFIGURATION FILES."
read -p "Do you really want to continue? (y/n): " CONTINUE
if [[ ! $CONTINUE =~ ^[y]$ ]]; then
    exit 1
fi


BACKUP_DIR=$HOME/backup_$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 6 | head -n 1)

echo
echo "Backup your files into $BACKUP_DIR ..."
mkdir $BACKUP_DIR
cp ~/.config/alacritty/alacritty.yml $BACKUP_DIR
cp ~/.zshrc $BACKUP_DIR
cp ~/.config/nvim/init.vim $BACKUP_DIR
cp ~/.gitconfig $BACKUP_DIR
cp ~/.gitignore $BACKUP_DIR
cp ~/.tmux.conf $BACKUP_DIR


# SETUP
# =====
#
# All the setup is made by sourcing config files instead of symlinking them.
# This allow to have custom configs for a particular machine.
# E.g. I need specific aliases or env vars for the work machine, I can add them
# only there without polluting the global configs. Or I want to try a plugin or
# software, I can do it locally before sharing it across all the machines.


# Alacritty
# ---------
echo 'Setup Alacritty...'
cat > ~/.config/alacritty/alacritty.yml <<EOF
import:
  - $DOTFILES_DIR/alacritty/alacritty.yml

EOF


# Zsh
# ---
echo 'Setup zsh...'

cat >> ~/.zshrc <<EOF
source "$DOTFILES_DIR/zshrc"

EOF


# Neovim
# ------
echo 'Setup Neovim...'
cat > ~/.config/nvim/init.vim <<EOF
source $DOTFILES_DIR/nvim/init.vim

EOF


# Git
# ---
echo 'Setup Git...'
cat > ~/.gitconfig <<EOF
[include]
    path=$DOTFILES_DIR/gitconfig

EOF

cat > ~/.gitignore <<EOF
$(cat $DOTFILES_DIR/gitignore)

EOF


# Tmux
# ----
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"


# Add man page for z script
sudo mkdir -p /usr/local/man/man1
sudo ln -sf "$DOTFILES_DIR/z/z.1" /usr/local/man/man1/z.1
sudo mandb

