function fish_user_key_bindings
    # https://github.com/warpdotdev/Warp/issues/3090
    if string match -q "$TERM_PROGRAM" "WarpTerminal"
        set fish_key_bindings fish_default_key_bindings
        return 0
    end
    # For those that didn't do this before
    # This solve some time Starship couldn't recognize vim mode
    fish_vi_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert

    # Then execute the vi-bindings so they take precedence when there's a conflict.
    # Without --no-erase fish_vi_key_bindings will default to
    # resetting all bindings.
    # The argument specifies the initial mode (insert, "default" or visual).
    fish_vi_key_bindings --no-erase insert

    # fzf stuff
    fzf_configure_bindings --directory=\co --git_log=\cgl --git_status=\cgs

    bind -M default \cp history-search-backward
    bind -M default \cn history-search-forward
    bind -M insert \cn history-search-forward

    bind -M insert \cgb 'fzf_git_recent_branch'
end
