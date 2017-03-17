#!/bin/bash

# install the plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#copy the configurations
cp resources/nvim.init.vim ~/.config/nvim/init.vim
mkdir -p ~/.config/nvim/after/colors/
cp resources/common.vim ~/.config/nvim/after/colors/common.vim
mkdir -p ~/.config/nvim/files/info/
touch ~/.config/nvim/files/info/viminfo

# install all the plugins
nvim +PlugInstall

git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
