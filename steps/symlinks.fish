#!/usr/bin/env fish

echo "creating symlink to ~"
mkdir -p ~/.config
set files_to_link .vimrc .tmux/.tmux.conf .tmux/.tmux.conf.local
for file in files_to_link
    if test -f ~/$file
        echo "backing up ~/$file to $file.bak"
        mv ~/$file ~/$file.bak
    end
    echo "ln -s ~/dotfiles/$file ~/"
    ln -s ~/dotfiles/$file ~/
end
ln -s ~/dotfiles/.vim ~/
ln -s ~/dotfiles/.gitconfig ~/
ln -s ~/dotfiles/starship.toml ~/.config/
ln -s ~/dotfiles/nvim ~/.config/
ln -s ~/dotfiles/zfunc ~/.config/zfunc
ln -s ~/dotfiles/bin/win32yank.exe ~/dotfiles/bin/win32yank

mkdir -p ~/.cargo
ln -s ~/dotfiles/cargo/config.toml ~/.cargo/config.toml

ln -s ~/dotfiles/.gnupg/gpg.conf ~/.gnupg/gpg.conf

# Fish stuff
mv ~/.config/fish ~/.config/fish.bak 2> /dev/null
ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -s ~/dotfiles/fish/fish_plugins ~/.config/fish/fish_plugins
ln -s ~/dotfiles/fish/my_conf_d.fish ~/.config/fish/conf.d/my_conf_d.fish
