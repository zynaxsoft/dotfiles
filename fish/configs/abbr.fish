if status is-interactive
    abbr -a tls tmux list-session
    abbr -a tks tmux_kill_session

    abbr -a rn source ranger

    abbr -a ls exa
    alias ll "exa --icons --git -lg"
    alias la "ll -a"
    alias et "et -I"

    abbr -a vim nvim
    abbr -a vi nvim
    abbr -a vimdiff nvim -d

    abbr -a stgn stg new
    abbr -a stgr stg refresh
    abbr -a stgri stg refresh -i
    abbr -a stgs stg series --description
    abbr -a stgss stg status

    abbr -a tf terraform
end
