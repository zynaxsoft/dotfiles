#!/bin/bash

echo "Adding custom ppa"
sudo add-apt-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo add-apt-repository -y ppa:fish-shell/release-3
sudo apt update

echo "Installing prerequisites"
sudo apt install -y fish git curl wget cmake build-essential libssl-dev openssl

fish ~/dotfiles/install.fish
