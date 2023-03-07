#!/bin/bash

echo "Installing Tools"
sudo apt install -y -o Dpkg::Options::="--force-overwrite" bat ripgrep fd-find
mkdir -p ~/.local/bin
ln -s $(which fdfind) ~/.local/bin/fd

# FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/bin/fzf
~/.local/bin/fzf/install --all

sudo apt install -y ranger gnome-tweaks xsel xclip
