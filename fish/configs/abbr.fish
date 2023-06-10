if status is-interactive
    abbr -a tls tmux list-session
    abbr -a tks tmux_kill_session

    abbr -a zl zellij
    abbr -a zlr zellij run --
    abbr -a zla zellij attach

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
    abbr -a osl openssl
    abbr -a po poetry

    function last_history_item
        echo $history[1]
    end
    # function n_argument_item
    #     set index (string replace "!" "" $argv)
    #     set args (string split " " $history[1])
    #     set -e args[1]
    #     echo ($args[$index])
    # end
    # function last_argument_item
    #     n_argument_item !-1
    # end
    abbr -a !! --position anywhere --function last_history_item
    # abbr -a !\$ --position anywhere --function last_argument_item
    # abbr -a n_args --position anywhere --function n_argument_item --regex "!-?\d"
end
