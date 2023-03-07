#!/bin/bash

echo "Installing stacked git"
git clone https://github.com/stacked-git/stgit stgit-install
pushd stgit-install > /dev/null
make prefix=$HOME/.local install
popd > /dev/null

echo "Installing rust tools"
cargo install exa&  # ls alternative
cargo install erdtree&  # beautiful tree
