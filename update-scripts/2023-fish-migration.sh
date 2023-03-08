#!/bin/bash

sudo add-apt-repository ppa:fish-shell/release-3 -y
sudo apt update
sudo apt remove fish -y
sudo apt install fish -y

rm -rf ~/.config/fish
mkdir -p ~/.config/fish
ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -s ~/dotfiles/fish/fish_plugins ~/.config/fish/fish_plugins

fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fisher update
yes | fish_config theme save Catppuccin\ Macchiato
