alias pact='source .env/bin/activate'
alias omore=$HOME/omotenashi/src/tools/omote-remote.py

alias tls='tmux list-session'
alias tks='_tmux_kill_session'

_tmux_kill_session() {
	tmux kill-session -t $1
}
