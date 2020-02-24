alias pact='_pacter'
alias omore=$HOME/tools/tools/omote-remote.py

alias tls='tmux list-session'
alias tks='_tmux_kill_session'

alias ga='git add -i'
alias ra='source ranger'

_tmux_kill_session() {
	tmux kill-session -t $1
}

_pacter() {
	if [ -d ".env" ]
	then
		source .env/bin/activate
	elif [ -d ".venv" ]
	then
		if [ -d ".venv/skill_env" ]
		then
			source .venv/skill_env/bin/activate
		else
			source .venv/bin/activate
		fi
	else
		echo 'could not find .env or .venv'
	fi
}
