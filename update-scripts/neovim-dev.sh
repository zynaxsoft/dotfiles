#!/bin/sh
sudo -E add-apt-repository --remove ppa:neovim-ppa/stable
sudo -E add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt upgrade neovim
