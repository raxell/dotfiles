cd ~

# Remove Vim if already installed
sudo apt remove vim vim-runtime gvim

# Install Vim dependencies
sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev \
	libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
	libcairo2-dev libx11-dev libxpm-dev libxt-dev

# Install editorconfig-vim dependencies
sudo apt-get install editorconfig

# Install Vim
if [ ! -d ~/vim ]; then
	git clone https://github.com/vim/vim.git
	cd vim
	./configure --enable-clipboard --enable-xterm_clipboard --with-features=huge
	make
	sudo make install
fi

# Setup Vim
if [ ! -L ~/.vim ] && [ ! -d ~/.vim ]; then
	ln -s ~/dotfiles/vim ~/.vim
fi

# Setup Git
if [ ! -L ~/.gitconfig ]; then
	ln -s ~/dotfiles/.gitconfig ~/.gitconfig
fi

