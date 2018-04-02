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
VIM_SOURCES=~/vim_sources

if [ ! -d $VIM_SOURCES ]; then
	git clone https://github.com/vim/vim.git $VIM_SOURCES
	cd $VIM_SOURCES
	./configure \
		--prefix=$HOME \
		--with-features=huge
	make
	make install
fi

# Setup Vim
if [ ! -L ~/.vim ] && [ ! -d ~/.vim ]; then
	ln -s ~/dotfiles/vim ~/.vim
fi

# Setup Git
if [ ! -L ~/.gitconfig ]; then
	ln -s ~/dotfiles/.gitconfig ~/.gitconfig
fi

