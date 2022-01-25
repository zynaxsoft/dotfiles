#!/bin/sh

echo "Install Nvim Treesitter plugins"
nvim -c ':TSInstall! rust python bash css html yaml json toml tsx vim cpp html c cmake http make regex javascript'
