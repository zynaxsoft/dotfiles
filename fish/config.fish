set -a fish_function_path \
    ~/.config/fish/functions/utils \
    ~/.config/fish/functions/git

if status is-interactive
    starship init fish | source
    eval ssh-agent > /dev/null
    set -gx GPG_TTY $(tty)
    set -gx EDITOR /usr/bin/nvim
end
