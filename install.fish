#!/usr/bin/env fish

set -x script_dir (dirname (status filename))
pushd $script_dir

# Prerequisites
./steps/symlinks.sh
export PATH=$PATH:$HOME/.cargo/bin

echo "Switching remote origin's URL of this git repo to ssh protocol"
git remote set-url origin 'git@github.com:zynaxsoft/dotfiles'

echo "initialize and update git submodules"
git submodule init
git submodule update

./steps/github_cli.sh
./steps/languages.sh
./steps/tools.sh
./steps/nerd_fonts.sh
./steps/vim_neovim.sh
./steps/shell_and_terminals.sh
./steps/gpg.sh
./steps/wsl_stuff.sh
./steps/tools_required_rust_installed.sh

echo "If wim32yank is slow. copy win32yank.exe to somewhere in Windows if you are using WSL2"
echo "Then do ln -s /mnt/c/path/to/win32yank.exe $HOME/dotfiles/bin/win32yank (without .exe)"

popd > /dev/null
