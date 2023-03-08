#!/bin/bash

sudo add-apt-repository ppa:fish-shell/release-3 -y
sudo apt update
sudo apt remove fish -y
sudo apt install fish -y

rm ~/.config/fish 2> /dev/null  # delete the old symlink if any
mv $HOME/.config/fish/config.fish $HOME/.config/fish/config.fish.bak 2> /dev/null
ln -s $HOME/dotfiles/fish/config.fish $HOME/.config/fish/config.fish
rm $HOME/.config/fish_plugins
ln -s $HOME/dotfiles/fish/config.fish $HOME/.config/fish/config.fish
ln -s $HOME/dotfiles/fish/fish_plugins $HOME/.config/fish/fish_plugins

curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher update
