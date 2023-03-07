function pact
    if test -d ".env"
        source .env/bin/activate
    else if test -d ".venv"
        source .venv/bin/activate
    else
        echo 'could not find .env or .venv'
    end
end
