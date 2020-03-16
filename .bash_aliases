alias runterminal="DISPLAY=:0 gnome-terminal -- zsh &"
alias runfullterminal="DISPLAY=$(cat /etc/resolv.conf | grep nameserver | head -2 | tail -1 | awk '{print $2}'):1 gnome-terminal --window-with-profile tanapol-full -- tmux &"
alias runfcitx="fcitx-autostart"
