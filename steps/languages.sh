#!/bin/bash

echo "installing python(s)"
sudo apt install -y python3 python3-pip
sudo apt install -y python3.10 python3.10-venv

echo "Installing Rust"
sudo apt install curl
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Installing rustup completions"
rustup completions zsh > ~/.config/zfunc/_rustup
rustup completions zsh cargo > ~/.config/zfunc/_cargo

echo "Installing Nodejs"
curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - &&\
sudo apt-get install -y nodejs
