set -a fish_function_path ~/dotfiles/fish/functions
set -a fish_complete_path ~/dotfiles/fish/completions

source ~/dotfiles/fish/configs/path.fish

if status is-interactive
    source ~/dotfiles/fish/configs/greetings.fish
    source ~/dotfiles/fish/configs/abbr.fish
    source ~/dotfiles/fish/configs/abbr-git.fish

    fzf_configure_bindings --directory=\ct

    set -l _nix_fish ~/.nix-profile/etc/profile.d/nix.fish
    if test -e $_nix_fish
      source $_nix_fish
    end

    starship init fish | source
    eval $(ssh-agent -c) > /dev/null
    set -gx GPG_TTY $(tty)
    set -gx EDITOR /usr/bin/nvim
end
