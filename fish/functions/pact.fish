function pact
    if test -d ".env"
        source .env/bin/activate.fish
    else if test -d ".venv"
        source .venv/bin/activate.fish
    else
        echo 'could not find .env or .venv'
    end
end
