#!/usr/bin/env fish

echo "installing nerd fonts"
mkdir -p ~/.local/share/fonts
cp fonts/* ~/.local/share/fonts/
fc-cache -f -v
