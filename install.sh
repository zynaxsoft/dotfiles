#!/bin/bash

pushd "$(dirname "$0")" > /dev/null

# test $(awk -F= '/^NAME/{print $2}' /etc/os-release) = "\"Ubuntu\"
echo "adding latest git and vim repository"
sudo add-apt-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:jonathonf/vim
sudo apt update

echo "installing gnome-tweaks"
sudo apt install -y gnome-tweaks

echo "installing nerd fonts"
mkdir -p ~/.local/share/fonts
cp fonts/dejavu-nerd-font.ttf ~/.local/share/fonts
fc-cache -f -v

echo "installing git and vim"
sudo apt install -y git
sudo apt install -y vim-gtk

echo "installing tmux"
sudo apt install -y tmux

echo "installing zsh"
sudo apt install -y zsh

echo "installing python(s)"
sudo apt install python3-pip python3.7 python3.8 python3.7-venv python3.8-venv


echo "creating symlink to $HOME"
for file in .vimrc .zshrc .tmux/.tmux.conf .tmux/.tmux.conf.local .oh-my-zsh .zsh-custom
    do
    if test -f "$HOME/$file"; then
            echo "backing up $HOME/$file to $file.bak"
            mv $HOME/$file $HOME/$file.bak
    fi
    echo "ln -s $HOME/dotfiles/$file $HOME/"
    ln -s $HOME/dotfiles/$file $HOME/
done
ln -s $HOME/dotfiles/.vim $HOME/
cp $HOME/dotfiles/.gitconfig $HOME/
git submodule init
git submodule update

echo "installing pylint3"
sudo apt install -y pylint3

echo "install clipboard tools"
sudo apt install -y xsel xclip

echo "install and config gpg-agent"
sudo apt install -y gnupg2 gnupg-agent
sudo apt install -y pinentry-tty
mv $HOME/.gnupg/{gpg-agent.conf,gpg-agent.conf.bak}
cp $HOME/dotfiles/.gnupg/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf
gpg-connect-agent reloadagent /bye

popd > /dev/null
