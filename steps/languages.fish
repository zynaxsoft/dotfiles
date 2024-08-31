#!/usr/bin/env fish

echo "installing python(s)"
sudo apt install -y python3 python3-pip

echo "Installing Rust"
sudo apt install -y curl
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Installing Nodejs"
# installs fnm (Fast Node Manager)
sudo apt install -y unzip
mkdir -p ~/.local/bin
curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.local/bin/fnm" --skip-shell
fish_add_path ~/.local/bin
fnm env --use-on-cd --shell fish | source
# download and install Node.js
fnm use --install-if-missing 22
