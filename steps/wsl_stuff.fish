#!/usr/bin/env fish

if uname -r | grep -qi microsoft
  echo "backing up wsl.conf to wsl.conf.bak"
  sudo cp -f /etc/wsl.conf /etc/wsl.conf.bak 2> /dev/null || true
  echo "copying wsl.conf to /etc/"
  sudo cp -f $HOME/dotfiles/wsl.conf /etc/wsl.conf
end
