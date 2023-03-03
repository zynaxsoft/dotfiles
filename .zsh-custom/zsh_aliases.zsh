alias pact='_pacter'
alias omore=$HOME/tools/tools/omote-remote.py

alias tls='tmux list-session'
alias tks='_tmux_kill_session'

alias ga='git add -i'
alias rn='source ranger'

alias ls='exa'
alias ll='ls --icons --git -lg'
alias la='ll -a'

alias vim='nvim'
alias vi='nvim'
alias vimdiff='nvim -d'

alias stgs='stg status'
alias stgss='stg series --description'

_tmux_kill_session() {
    tmux kill-session -t $1
}

alias tf='terraform'

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
