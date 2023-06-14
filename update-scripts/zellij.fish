#!/usr/bin/env fish
# Install zellij first
if not type -q zellij
    echo "Install zellij first"
    exit 1
end
ln -s ~/dotfiles/zellij ~/.config/zellij
zellij setup --generate-completion fish > ~/.local/share/fish/generated_completions/zellij.fish
