#!/usr/bin/env fish

echo "install and config gpg-agent"
sudo apt install -y gnupg2 gnupg-agent
sudo apt install -y pinentry-tty
mv $HOME/.gnupg/{gpg-agent.conf,gpg-agent.conf.bak}
mkdir -p $HOME/.gnupg
cp $HOME/dotfiles/.gnupg/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf
gpg-connect-agent reloadagent /bye

