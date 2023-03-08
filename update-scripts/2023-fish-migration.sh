#!/bin/bash

sudo add-apt-repository ppa:fish-shell/release-3 -y
sudo apt update
sudo apt remove fish -y
sudo apt install fish -y

mv $HOME/.config/fish $HOME/.config/fish.bak 2> /dev/null
ln -s $HOME/dotfiles/fish $HOME/.config/fish
