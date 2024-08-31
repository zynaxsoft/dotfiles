starship init fish | source
if type -q zoxide
    zoxide init fish | source
end
if type -q fnm
    fnm env --use-on-cd --shell fish | source
end
eval $(ssh-agent -c) > /dev/null
