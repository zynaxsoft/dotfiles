#!/bin/bash

pushd "$(dirname "$0")" > /dev/null

echo "creating symlink to $HOME"
for file in .vimrc .zshrc .tmux/.tmux.conf .tmux/.tmux.conf.local .oh-my-zsh .gitconfig
	do
	if test -f "$HOME/$file"; then
		echo "backing up $HOME/$file to $file.bak"
	fi
	echo "ln -s $HOME/dotfiles/$file $HOME/"
done

popd > /dev/null
