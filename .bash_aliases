function _get_host_ip() {
    # local IP=$(ip addr sh $(ip route list default | grep -Po ' dev \K\w+') | grep -Po ' inet \K[\d.]+')
    local IP=$(ipconfig.exe | grep "WSL" -A 5 | grep "IPv4" | awk -F: '{print $2}' | xargs echo)
    echo $IP | tr -d '\r'
}

function _run_term() {
    local IP=$(_get_host_ip)
    export DISPLAY="${IP}:0"
    echo $DISPLAY
    gnome-terminal -- zsh &
}

# alias runterminal="DISPLAY=$(_get_host_ip):0 gnome-terminal"
alias runterminal=_run_term
alias runfullterminal="DISPLAY=$(_get_host_ip):0 gnome-terminal --window-with-profile tanapol-full -- tmux &"
alias runfcitx="fcitx-autostart"

alias vim='nvim'
alias vi='nvim'
alias vimdiff='nvim -d'

export EDITOR='nvim'
