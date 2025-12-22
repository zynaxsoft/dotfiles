#!/usr/bin/env fish

function _link -d \
    "1st arg is the file in dotfiles, 2nd arg is the folder \
    it assumes you kindly put a backslash at the end."
    set from ~/dotfiles/$argv[1]
    set target (basename $from)
    if test (count $argv) -lt 2
        set to $HOME/$target
    else
        set to ~/$argv[2]$target
    end
    if not test -L $to
        echo $to is not a symlink. Creating a back up.
        echo mv $to $to.bak
        mv $to $to.bak
    end
    echo ln -sfT $from $to
    ln -sfT $from $to
end


_link .vimrc
_link .tmux/.tmux.conf
_link .tmux/.tmux.conf.local
_link .gitconfig

mkdir -p ~/.config
_link starship.toml .config/
_link nvim .config/
_link fish/config.fish .config/fish/
_link fish/fish_plugins .config/fish/
_link fish/my_conf_d.fish .config/fish/conf.d/
_link zellij .config/
_link kitty .config/
_link ghostty .config/
_link opencode/opencode.json .config/opencode
_link gitui .config/
_link bat .config/
_link claude/commands .claude/
_link claude/output-styles .claude/
_link gemini/commands .gemini/
ln -s ~/dotfiles/bacon-prefs.toml ~/.config/bacon/prefs.toml

mkdir -p ~/.cargo
_link cargo/config.toml .cargo/

mkdir -p ~/.gnupg
_link .gnupg/gpg.conf .gnupg/

ln -s ~/dotfiles/bin/win32yank.exe ~/dotfiles/bin/win32yank

functions -e _link
