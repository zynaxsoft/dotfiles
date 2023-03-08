#!/usr/bin/env fish

echo "creating symlink to $HOME"
mkdir -p $HOME/.config
set files_to_links .vimrc .tmux/.tmux.conf .tmux/.tmux.conf.local
for file in files_to_links
    if test -f $HOME/$file
        echo "backing up $HOME/$file to $file.bak"
        mv $HOME/$file $HOME/$file.bak
    end
    echo "ln -s $HOME/dotfiles/$file $HOME/"
    ln -s $HOME/dotfiles/$file $HOME/
end
ln -s $HOME/dotfiles/.vim $HOME/
ln -s $HOME/dotfiles/.gitconfig $HOME/
ln -s $HOME/dotfiles/starship.toml $HOME/.config/
ln -s $HOME/dotfiles/nvim $HOME/.config/
ln -s $HOME/dotfiles/zfunc $HOME/.config/zfunc
ln -s $HOME/dotfiles/bin/win32yank.exe $HOME/dotfiles/bin/win32yank
mv $HOME/.config/fish $HOME/.config/fish.bak 2> /dev/null
ln -s $HOME/dotfiles/fish $HOME/.config/fish
