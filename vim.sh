#!/bin/bash

# install the plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#copy the configurations
cp resources/nvim.init.vim ~/.config/nvim/init.vim
mkdir -p ~/.config/nvim/after/colors/
cp resources/common.vim ~/.config/nvim/after/colors/common.vim
mkdir -p ~/.config/nvim/files/info/
touch ~/.config/nvim/files/info/viminfo

#install colorscheme
mkdir -p ~/.config/nvim/colors
cd ~/.config/nvim/colors
wget https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

# install all the plugins
vim +PlugInstall

git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
