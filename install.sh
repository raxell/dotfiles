cd ~

# Load terminal theme file
dconf load /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ < ~/dotfiles/terminal-theme.dconf

sudo apt update

sudo apt install build-essential

# Install java
sudo apt install openjdk-8-jdk

# Install curl
sudo apt install curl

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
		--with-features=huge \
		--disable-gui
	make
	make install
fi

# Setup Vim
mkdir -p ~/.vim

ln -sf ~/dotfiles/vim/vimrc ~/.vim/vimrc

mkdir -p ~/.vim/snippets
ln -sf ~/dotfiles/vim/snippets ~/.vim/snippets

# Setup Git
ln -sf ~/dotfiles/gitconfig ~/.gitconfig

# Install redis
REDIS_DIR=~/redis

if [ ! -d $REDIS_DIR ]; then
	wget http://download.redis.io/redis-stable.tar.gz
	tar xzf redis-stable.tar.gz
	rm redis-stable.tar.gz
	mv redis-stable $REDIS_DIR
	cd $REDIS_DIR
	make
	ln -s $REDIS_DIR/src/redis-server ~/bin
	ln -s $REDIS_DIR/src/redis-cli ~/bin
fi

# Install dart
if [ ! -d /usr/lib/dart ]; then
	sudo apt install apt-transport-https
	sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
	sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
	sudo apt update
	sudo apt install dart
fi

ln -sf ~/dotfiles/bashrc ~/.bashrc

# Add man page for z script
sudo mkdir -p /usr/local/man/man1
sudo ln -sf ~/dotfiles/z/z.1 /usr/local/man/man1/z.1
sudo mandb

