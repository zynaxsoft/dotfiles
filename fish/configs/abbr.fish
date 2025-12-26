if status is-interactive
    abbr -a tls tmux list-session
    abbr -a tks tmux_kill_session

    abbr -a cld claude
    abbr -a cldp claude -p
    abbr -a cldm claude --model
    abbr -a cldmh claude --model haiku
    abbr -a cldms claude --model sonnet[1m]
    abbr -a cldmo claude --model opus
    abbr -a gmn gemini
    abbr -a opc opencode

    abbr -a zl zellij
    abbr -a zlr zellij run --
    abbr -a zla zellij attach

    abbr -a fg figma
    abbr -a fgc figma connect
    abbr -a fgcp figma connect publish

    abbr -a rn source ranger

    abbr -a ls eza
    alias ll "eza --icons --git -lg"
    alias la "ll -a"
    alias et "et -I"
    alias z "zoxide"

    abbr -a vim nvim
    abbr -a vi nvim
    abbr -a vimdiff nvim -d

    abbr -a stgn stg new
    abbr -a stge stg edit
    abbr -a stgr stg refresh
    abbr -a stgrp stg refresh -p
    abbr -a stgri stg refresh -i
    abbr -a stgrip stg refresh -i -p
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
