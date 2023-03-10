# See ~/dotfiles/fish/my_conf_d.fish 
# See ~/dotfiles/fish/conf.d/my_path.fish for path customization

if test -z $DISPLAY
    set -gx DISPLAY :1
    tmux set-option -g update-environment DISPLAY
end

if status is-interactive
    source ~/dotfiles/fish/configs/greetings.fish
    source ~/dotfiles/fish/configs/abbr.fish
    source ~/dotfiles/fish/configs/abbr-git.fish

    set -gx COLORTERM truecolor
    set -gx GPG_TTY $(tty)
    set -gx EDITOR /usr/bin/nvim

    fzf_configure_bindings --directory=\ct

    starship init fish | source
    eval $(ssh-agent -c) > /dev/null
end
