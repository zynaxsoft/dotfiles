starship init fish | source
if type -q zoxide
    zoxide init fish | source
end
if type -q fnm
    fnm env --use-on-cd --shell fish | source
end
if not set -q SSH_AUTH_SOCK; or not test -S "$SSH_AUTH_SOCK"
    eval (ssh-agent -c) > /dev/null
end
