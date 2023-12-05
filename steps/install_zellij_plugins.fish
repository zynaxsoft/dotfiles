#!/usr/bin/env fish

set plugin_path ~/.local/share/zellij

function _get
    curl -L $argv[1] -o $plugin_path/$argv[2]
end

mkdir -p $plugin_path
_get https://github.com/dj95/zjstatus/releases/download/v0.9.2/zjstatus.wasm zjstatus.wasm
