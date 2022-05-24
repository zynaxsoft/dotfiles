#!/bin/sh
sudo -E add-apt-repository -y --remove ppa:neovim-ppa/stable
sudo -E add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt upgrade -y neovim
