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

# Setup Git
ln -sf "$HOME/dotfiles/gitconfig" "$HOME/.gitconfig"
ln -sf "$HOME/dotfiles/gitignore" "$HOME/.gitignore"

# Setup bash
ln -sf "$HOME/dotfiles/bashrc" "$HOME/.bashrc"

# Add man page for z script
sudo mkdir -p /usr/local/man/man1
sudo ln -sf "$HOME/dotfiles/z/z.1" /usr/local/man/man1/z.1
sudo mandb

# Setup todo-txt
mkdir "$HOME/.todo"
ln -sf "$HOME/dotfiles/todo/config" "$HOME/.todo/config"
ln -sf "$HOME/dotfiles/todo/actions" "$HOME/.todo/actions"

# Tmux setup
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf "$HOME/dotfiles/tmux.conf" "$HOME/.tmux.conf"

# Zsh setup
ln -sf "$HOME/dotfiles/zshrc" "$HOME/.zshrc"

