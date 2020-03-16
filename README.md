<img src="https://user-images.githubusercontent.com/1210722/66711562-2c5ccf00-edc9-11e9-947d-5c0f2e7add32.png" width=300><br>

# my-dotfiles

A personal repo for keeping Tanapol's dotfiles

## Procedure
1. `cd ~`
2. `git clone git@gitlab.com:tanapol/my-dotfiles.git dotfiles`
3. `cd dotfiles` 
4. `./install-dry.sh` to check the symlink creation to your $HOME directory
5. `./install.sh` to install

## Requirements
* vim 8.1 or something newer than the current vim version in ubuntu 18.04
  * vim can be downloaded from ubuntu ppa or built directly from the github (ref: https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source)
* `pip3 install pylint mypy flake8 flake8-import-order autopep8 black isort`


## WSL2
vcxsrv requires -ac option (disable access control in the wizard)
The ip of the host pc must be used for DISPLAY variable. This can be obtained by
looking at `/etc/resolv.conf` (172.something). This can be taken out by

`cat /etc/resolv.conf | grep nameserver | head -2 | tail -1 | awk '{print $2}'):1`

Note that this assumes that the 172.something is on the second line.

edit resolv.conf to your prefered DNS. (1.1.1.1, 8.8.8.8, or your dns cache server)
