#!/usr/bin/env fish

set -x script_dir (dirname (status filename))
pushd $script_dir > /dev/null

# Prerequisites
./steps/symlinks.fish
fish_add_path -a ~/.cargo/bin

echo "Switching remote origin's URL of this git repo to ssh protocol"
git remote set-url origin 'git@github.com:zynaxsoft/dotfiles'

# echo "initialize and update git submodules"
# git submodule init
# git submodule update

./steps/github_cli.fish
./steps/languages.fish
./steps/tools.fish
./steps/nerd_fonts.fish
./steps/vim_neovim.fish
./steps/shell_and_terminals.fish
./steps/gpg.fish
./steps/wsl_stuff.fish
./steps/tools_required_rust_installed.fish
./update-scripts/zellij.fish
./steps/install_zellij_plugins.fish

echo "If wim32yank is slow. copy win32yank.exe to somewhere in Windows if you are using WSL2"
echo "Then do ln -s /mnt/c/path/to/win32yank.exe $HOME/dotfiles/bin/win32yank (without .exe)"

popd > /dev/null
