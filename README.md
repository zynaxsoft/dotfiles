<img src="/uploads/d661878ab664c4fb2934c03e8f15949a/image.png" width=300><br>
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
