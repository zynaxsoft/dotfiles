set -a fish_function_path \
    ~/.config/fish/functions/utils \
    ~/.config/fish/functions/git

set -gx GPG_TTY $(tty)
set -gx EDITOR /usr/bin/nvim

eval ssh-agent > /dev/null

if status is-interactive
    starship init fish | source
end
