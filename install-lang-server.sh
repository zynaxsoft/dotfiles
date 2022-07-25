#!/bin/sh

# python
pip3 install pyright flake8 pylint black

# --- Deprecation
# Moved to use Mason.vim to manage these things

# rust analyzer
# mkdir -p ~/.local/bin
# rm -f ~/.local/bin/rust-analyzer
# curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
# chmod +x ~/.local/bin/rust-analyzer

# lua
# sudo apt install -y luacheck
# cargo install stylua
# cargo install selene

# taplo
# cargo install --features lsp --locked taplo-cli
