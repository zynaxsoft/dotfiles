#!/usr/bin/env fish

echo "install vim & neovim"
sudo apt install -y neovim vim-gtk

echo "Installing nvim plugins"
# 2 times just to be sure
nvim --headless "+Lazy! sync" +qa
nvim --headless "+Lazy! sync" +qa
nvim --headless -c 'TSInstall all'&
