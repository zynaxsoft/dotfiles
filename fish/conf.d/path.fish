if uname -r | grep -qi microsoft
    set PATH ~/.cargo/bin ~/bin ~/.local/bin \
        /usr/local/sbin /usr/local/bin \
        /usr/sbin /usr/bin /sbin
    if test -z $DISPLAY
        set -gx DISPLAY :1
        tmux set-option -g update-environment DISPLAY
    end
else
    set -a PATH ~/.cargo/bin
end
