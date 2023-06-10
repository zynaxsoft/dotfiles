#!/usr/bin/env fish
# Install zellij first
if not type -q zellij
    echo "Install zellij first"
    exit 1
end
mkdir -p ~/.config/zellij
ln -s ~/dotfiles/zellij/config.kdl ~/.config/zellij/config.kdl
zellij setup --generate-completion fish > ~/.local/share/fish/generated_completions/zellij.fish
