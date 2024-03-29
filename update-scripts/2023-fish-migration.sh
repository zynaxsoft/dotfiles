#!/bin/bash

sudo add-apt-repository ppa:fish-shell/release-3 -y
sudo apt update
sudo apt remove fish -y
sudo apt install fish -y

rm -rf ~/.config/fish
mkdir -p ~/.config/fish
ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -s ~/dotfiles/fish/fish_plugins ~/.config/fish/fish_plugins
ln -s ~/dotfiles/fish/my_conf_d.fish ~/.config/fish/conf.d/my_conf_d.fish

~/dotfiles/steps/symlinks.fish
fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fish -c "fisher update"
fish -c "yes | fish_config theme save Catppuccin\ Macchiato"
