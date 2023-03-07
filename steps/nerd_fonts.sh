#!/bin/bash

echo "installing nerd fonts"
mkdir -p ~/.local/share/fonts
cp fonts/dejavu-nerd-font.ttf ~/.local/share/fonts
cp fonts/fira-code-nf.ttf ~/.local/share/fonts
cp fonts/victor-mono-medium-nf.ttf ~/.local/share/fonts
fc-cache -f -v
