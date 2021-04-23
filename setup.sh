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


# Setup zsh
# Source instead of symlink to allow to add machine specific settings
echo 'Setup zsh...'

cat >> ~/.zshrc <<EOF
source "$DOTFILES_DIR/zshrc"

EOF


# Setup Git
ln -sf "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/gitignore" "$HOME/.gitignore"

# Setup bash
ln -sf "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"

# Add man page for z script
sudo mkdir -p /usr/local/man/man1
sudo ln -sf "$DOTFILES_DIR/z/z.1" /usr/local/man/man1/z.1
sudo mandb

# Setup todo-txt
mkdir "$HOME/.todo"
ln -sf "$DOTFILES_DIR/todo/config" "$HOME/.todo/config"
ln -sf "$DOTFILES_DIR/todo/actions" "$HOME/.todo/actions"

# Tmux setup
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"

