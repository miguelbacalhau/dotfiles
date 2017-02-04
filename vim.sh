#!/bin/bash

# install the plugin manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

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
vim +PluginInstall +qall

#install powerline fonts
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh

#build vimproc
cd ~/.vim/bundle/vimproc.vim
make
