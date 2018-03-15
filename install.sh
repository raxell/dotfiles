cd ~

# Install Vim
if [ ! -d ~/vim ]; then
	git clone https://github.com/vim/vim.git
	cd vim
	./configure --with-features=huge
	make
	make install
fi

# Setup Vim
if [ ! -L ~/.vim ] && [ ! -d ~/.vim ]; then
	ln -s ~/dotfiles/vim ~/.vim
fi

