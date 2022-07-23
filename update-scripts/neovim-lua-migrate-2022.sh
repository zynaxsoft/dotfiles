#!/bin/bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/bin/fzf
~/.local/bin/fzf/install --all
rm -rf ~/dotfiles/nvim/plugged
rm -rf ~/dotfiles/nvim/autoload/vim-plug
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
     ~/.local/share/nvim/site/pack/packer/start/packer.nvim
vim +PackerSync
