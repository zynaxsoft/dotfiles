#!/usr/bin/env fish

echo "install vim & neovim"
sudo apt install -y neovim vim-gtk
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

echo "Installing nvim plugins"
# 2 times just to be sure
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'&
nvim --headless -c 'TSInstall all'&
