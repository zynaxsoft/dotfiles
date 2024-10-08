#!/usr/bin/env fish

echo "Installing stacked git"
git clone https://github.com/stacked-git/stgit stgit-install
pushd stgit-install > /dev/null
make prefix=$HOME/.local install
make -f ./completion/Makefile install
popd > /dev/null

echo "Installing rust tools"
cargo install eza&
cargo install erdtree&  # beautiful tree
cargo install zellij&
