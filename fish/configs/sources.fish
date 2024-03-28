starship init fish | source
if type -q zoxide
    zoxide init fish | source
end
eval $(ssh-agent -c) > /dev/null
