#!/bin/bash

# install the plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#copy the configurations
cp resources/vimrc.vim ~/.vimrc
cp resources/gvimrc.vim ~/.gvimrc
mkdir -p ~/.vim/after/colors/
cp resources/common.vim ~/.vim/after/colors/common.vim
mkdir -p ~/.vim/files/info/
touch ~/.vim/files/info/viminfo

#install colorscheme
mkdir -p ~/.vim/colors
cd ~/.vim/colors
wget https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

# install all the plugins
vim +PlugInstall

git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
