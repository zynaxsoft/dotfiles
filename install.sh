#!/bin/bash

pushd "$(dirname "$0")" > /dev/null

echo "creating symlink to $HOME"
for file in .vimrc .zshrc .tmux/.tmux.conf .tmux/.tmux.conf.local .oh-my-zsh .gitconfig
	do
	if test -f "$HOME/$file"; then
		echo "backing up $HOME/$file to $file.bak"
		mv $HOME/$file $HOME/$file.bak
	fi
	echo "ln -s $HOME/dotfiles/$file $HOME/"
	ln -s $HOME/dotfiles/$file $HOME/
done
git submodule init
git submodule update

echo "installing pylint3"
sudo apt install pylint3

popd > /dev/null
