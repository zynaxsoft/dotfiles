#!/bin/bash

pushd "$(dirname "$0")" > /dev/null

# test $(awk -F= '/^NAME/{print $2}' /etc/os-release) = "\"Ubuntu\"
echo "adding latest git, nvim, and github cli repository"
sudo add-apt-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:neovim-ppa/unstable
# github cli
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository -y https://cli.github.com/packages
sudo apt update

# install github cli
sudo apt install -y gh

# install curl
sudo apt install -y curl

echo "initialize and update git submodules"
git submodule init
git submodule update

echo "installing gnome-tweaks"
sudo apt install -y gnome-tweaks

echo "installing ranger"
sudo apt install -y ranger

echo "installing tools"
sudo apt install -y -o Dpkg::Options::="--force-overwrite" bat ripgrep fd-find
ln -s $(which fdfind) ~/.local/bin/fd
sudo apt install -y fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/bin/fzf
~/.local/bin/fzf/install --all

echo "installing nerd fonts"
mkdir -p ~/.local/share/fonts
cp fonts/dejavu-nerd-font.ttf ~/.local/share/fonts
cp fonts/fira-code-nf.ttf ~/.local/share/fonts
cp fonts/victor-mono-medium-nf.ttf ~/.local/share/fonts
fc-cache -f -v

echo "installing vim"
sudo apt install -y vim-gtk

echo "install neovim"
sudo apt install -y neovim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

echo "installing tmux"
sudo apt install -y tmux

echo "installing zsh"
sudo apt install -y zsh
zsh -ic "compaudit | xargs chmod g-w,o-w" || true

# echo "install wezterm"
# curl -LO https://github.com/wez/wezterm/releases/download/20220101-133340-7edc5b5a/wezterm-20220101-133340-7edc5b5a.Ubuntu20.04.deb
# sudo apt install -y ./wezterm-20220101-133340-7edc5b5a.Ubuntu20.04.deb
# # make wezterm default terminal
# sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/wezterm 50

echo "install starship prompt"
curl -fsSL https://starship.rs/install.sh | sh -s -- -y

echo "installing python(s)"
sudo apt install -y python python3-pip
sudo apt install -y python3.7 python3.7-venv
sudo apt install -y python3.8 python3.8-venv
sudo apt install -y python3.9 python3.9-venv
sudo apt install -y python3.10 python3.10-venv
pip3 install flake8 pylint
pip3 install jedi

echo "installing rust"
sudo apt install curl
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
alias cargo="$HOME/.cargo/bin/cargo"

echo "creating symlink to $HOME"
mkdir -p $HOME/.config
for file in .vimrc .zshrc .tmux/.tmux.conf .tmux/.tmux.conf.local .oh-my-zsh .zsh-custom .wezterm.lua
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

echo "installing pylint3"
sudo apt install -y pylint3

echo "installing nvim plugins"
sudo apt install -y cmake
nvim +PackerSync +qall

echo "install clipboard tools"
sudo apt install -y xsel xclip

echo "install and config gpg-agent"
sudo apt install -y gnupg2 gnupg-agent
sudo apt install -y pinentry-tty
mv $HOME/.gnupg/{gpg-agent.conf,gpg-agent.conf.bak}
mkdir -p $HOME/dotfiles/.gnupg
ln -s $HOME/dotfiles/.gnupg/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf
gpg-connect-agent reloadagent /bye

# WSL stuff
if uname -r | grep -qi microsoft; then
  echo "backing up wsl.conf to wsl.conf.bak"
  sudo cp -f /etc/wsl.conf /etc/wsl.conf.bak 2> /dev/null || true
  echo "copying wsl.conf to /etc/"
  sudo cp -f $HOME/dotfiles/wsl.conf /etc/wsl.conf
fi

echo "installing rustup completions"
CARGO_DIR=$HOME/.cargo/bin
$CARGO_DIR/rustup completions zsh > ~/.config/zfunc/_rustup
$CARGO_DIR/rustup completions zsh cargo > ~/.config/zfunc/_cargo

echo "installing rust tools"
$CARGO_DIR/cargo install exa&  # ls alternative

echo "installing langauge servers"
./install-lang-server.sh
./install-nvim-treesitter-plugins.sh

echo "set url origin of this git repo to ssh protocol"
git remote set-url origin 'git@github.com:zynaxsoft/dotfiles'

echo "If wim32yank is slow. copy win32yank.exe to somewhere in Windows if you are using WSL2"
echo "Then do ln -s /mnt/c/path/to/win32yank.exe $HOME/dotfiles/bin/win32yank (without .exe)"

popd > /dev/null
