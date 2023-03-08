#!/bin/bash

echo "creating symlink to $HOME"
mkdir -p $HOME/.config
for file in .vimrc .tmux/.tmux.conf .tmux/.tmux.conf.local
    do
    if test -f "$HOME/$file"; then
            echo "backing up $HOME/$file to $file.bak"
            mv $HOME/$file $HOME/$file.bak
    fi
    echo "ln -s $HOME/dotfiles/$file $HOME/"
    ln -s $HOME/dotfiles/$file $HOME/
done
ln -s $HOME/dotfiles/.vim $HOME/
ln -s $HOME/dotfiles/.gitconfig $HOME/
ln -s $HOME/dotfiles/starship.toml $HOME/.config/
ln -s $HOME/dotfiles/nvim $HOME/.config/
ln -s $HOME/dotfiles/zfunc $HOME/.config/zfunc
ln -s $HOME/dotfiles/bin/win32yank.exe $HOME/dotfiles/bin/win32yank
mv $HOME/.config/fish $HOME/.config/fish.bak 2> /dev/null
ln -s $HOME/dotfiles/fish $HOME/.config/fish
