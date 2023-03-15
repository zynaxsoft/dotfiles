function fish_user_key_bindings
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

    bind -M default \cp history-search-backward
    bind -M default \cn history-search-forward
end
