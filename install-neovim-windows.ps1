choco install neovim --pre
New-Item -ItemType SymbolicLink -Target "C:\Users\zynax\dotfiles\nvim\" -Path "C:\Users\zynax\AppData\Local\nvim"
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
nvim +PackerSync
