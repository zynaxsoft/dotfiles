#!/bin/bash

echo "installing tmux"
sudo apt install -y tmux

echo "installing zsh"
sudo apt install -y zsh
zsh -ic "compaudit | xargs chmod g-w,o-w" || true

echo "install starship prompt"
curl -fsSL https://starship.rs/install.sh | sh -s -- -y

