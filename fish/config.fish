# See ~/dotfiles/fish/my_conf_d.fish 
# See ~/dotfiles/fish/conf.d/my_path.fish for path customization
#
# Why my_conf_d? Because our functions/fish_reload source this file which is make things
# that are not idempotent mess up the environment, e.g., `set -a fish_complete_path`
# Also we could put things that are not required for reload in our conf.d.

# if test -z $DISPLAY
#     set -gx DISPLAY :1
#     tmux set-option -g update-environment DISPLAY
# end

if status is-interactive
    source ~/dotfiles/fish/configs/greetings.fish
    source ~/dotfiles/fish/configs/abbr.fish
    source ~/dotfiles/fish/configs/abbr-git.fish
    source ~/dotfiles/fish/configs/host.fish

    set -gx COLORTERM truecolor
    set -gx GPG_TTY $(tty)
    set -gx EDITOR /usr/bin/nvim

    starship init fish | source
    eval $(ssh-agent -c) > /dev/null
end
