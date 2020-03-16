function _get_host_ip() {
    # local IP=$(ip addr sh $(ip route list default | grep -Po ' dev \K\w+') | grep -Po ' inet \K[\d.]+')
    local IP=$(ipconfig.exe | grep "WSL" -A 5 | grep "IPv4" | awk -F: '{print $2}' | xargs echo)
    echo $IP
}

alias runterminal="DISPLAY=$(_get_host_ip):0 gnome-terminal -- zsh &"
alias runfullterminal="DISPLAY=$(_get_host_ip):1 gnome-terminal --window-with-profile tanapol-full -- tmux &"
alias runfcitx="fcitx-autostart"
