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

# SETUP
# =====
#
# All the setup is made by sourcing config files instead of symlinking them.
# This allow to have custom configs for a particular machine.
# E.g. I need specific aliases or env vars for the work machine, I can add them
# only there without polluting the global configs. Or I want to try a plugin or
# software, I can do it locally before sharing it across all the machines.


# Alacritty
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
ln -sf "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/gitignore" "$HOME/.gitignore"




# Tmux
# ----
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"


# Add man page for z script
sudo mkdir -p /usr/local/man/man1
sudo ln -sf "$DOTFILES_DIR/z/z.1" /usr/local/man/man1/z.1
sudo mandb


