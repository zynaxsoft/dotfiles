#!/bin/bash

echo "installing tmux"
sudo apt install -y tmux

echo "installing fish"
sudo apt install fish

echo "install starship prompt"
curl -fsSL https://starship.rs/install.sh | sh -s -- -y

