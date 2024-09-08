set -p fish_function_path ~/dotfiles/fish/functions
set -p fish_complete_path ~/dotfiles/fish/completions

# PATH stuff
fish_add_path ~/.cargo/bin ~/.local/bin ~/.ghcup/bin

# bun
if test -d ~/.bun
    fish_add_path ~/.bun/bin
end
