#!/bin/bash

pushd "$(dirname "$0")" > /dev/null

# test $(awk -F= '/^NAME/{print $2}' /etc/os-release) = "\"Ubuntu\"
echo "adding latest git and vim repository and github cli"
sudo add-apt-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:jonathonf/vim
# github cli
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository -y https://cli.github.com/packages
sudo apt update

# install github cli
sudo apt install -y gh

echo "initialize and update git submodules"
git submodule init
git submodule update

echo "installing gnome-tweaks"
sudo apt install -y gnome-tweaks

echo "installing ranger"
sudo apt install -y ranger

echo "installing fzf"
sudo apt install -y fzf

echo "installing nerd fonts"
mkdir -p ~/.local/share/fonts
cp fonts/dejavu-nerd-font.ttf ~/.local/share/fonts
fc-cache -f -v

echo "installing git and vim"
sudo apt install -y git
sudo apt install -y vim-gtk

echo "installing tmux by compiling from source"
pushd tmux
sudo apt remove -y tmux
sudo apt install -y libevent-dev bison flex autoconf automake pkg-config ncurses-dev
git checkout 2.9a
sh autogen.sh
./configure > /dev/null
make > /dev/null
if test -f "/usr/bin/tmux"; then
    echo "/usr/bin/tmux still exists after doing 'apt remove tmux'." \
         "Confirm if you don't have other version of tmux then'" \
         "perform 'rm /usr/bin/tmux'"
    exit 1
fi
sudo ln -s $HOME/dotfiles/tmux/tmux /usr/bin/tmux
popd

echo "installing zsh"
sudo apt install -y zsh
zsh -ic "compaudit | xargs chmod g-w,o-w" || true

echo "install starship prompt"
curl -fsSL https://starship.rs/install.sh | bash -s -- -y 

echo "installing python(s)"
sudo apt install -y python3-pip python3.7 python3.8 python3.7-venv python3.8-venv
pip3 install flake8 pylint
pip3 install jedi

echo "installing rust"
sudo apt install curl
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
rustup component add rls

echo "installing node"
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
sudo apt-get install -y nodejs


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
ln -s $HOME/dotfiles/.gitconfig $HOME/

echo "installing pylint3"
sudo apt install -y pylint3

echo "installing vim plugins"
sudo apt install -y cmake
vim +PlugInstall +qall
vim -c 'CocInstall -sync coc-json coc-html coc-python coc-rust-analyzer coc-yaml coc-tsserver coc-css|q'

echo "install clipboard tools"
sudo apt install -y xsel xclip

echo "install and config gpg-agent"
sudo apt install -y gnupg2 gnupg-agent
sudo apt install -y pinentry-tty
mv $HOME/.gnupg/{gpg-agent.conf,gpg-agent.conf.bak}
cp $HOME/dotfiles/.gnupg/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf
gpg-connect-agent reloadagent /bye

# WSL stuff
if uname -r | grep -qi microsoft; then
  echo "backing up wsl.conf to wsl.conf.bak"
  sudo cp -f /etc/wsl.conf /etc/wsl.conf.bak 2> /dev/null || true
  echo "copying wsl.conf to /etc/"
  sudo cp -f $HOME/dotfiles/wsl.conf /etc/wsl.conf
fi

echo "installing rust tools"
cargo install exa&  # ls alternative
cargo install ripgrep&  # grep alternative
cargo install bat&  # cat alternative

popd > /dev/null
