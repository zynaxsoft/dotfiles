#!/bin/bash

echo "installing tmux"
sudo apt install -y tmux

echo "installing fish"
sudo apt install fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher update
fish_config theme choose "Catppuccin Macchiato"
yes | fish_config theme save

echo "install starship prompt"
curl -fsSL https://starship.rs/install.sh | sh -s -- -y

