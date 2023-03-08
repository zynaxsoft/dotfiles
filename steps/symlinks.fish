#!/usr/bin/env fish

echo "creating symlink to $HOME"
mkdir -p $HOME/.config
set files_to_link .vimrc .tmux/.tmux.conf .tmux/.tmux.conf.local
for file in files_to_link
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
ln -s $HOME/dotfiles/fish/config.fish $HOME/.config/fish/config.fish
ln -s $HOME/dotfiles/fish/fish_plugins $HOME/.config/fish/fish_plugins
