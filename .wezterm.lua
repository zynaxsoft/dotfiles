local wezterm = require 'wezterm';

Config = {
    color_scheme = "Builtin Solarized Dark",
    hide_tab_bar_if_only_one_tab = true,
    window_padding = {
        left = 3,
        right = 0,
        top = 0,
        bottom = 0,
    },
    enable_scroll_bar = false,
    audible_bell = "Disabled",

    warn_about_missing_glyphs = false,

    keys = {
        -- Turn this off because we're going to use theses in tmux.
        {key="LeftArrow", mods="CTRL|SHIFT", action="DisableDefaultAssignment"},
        {key="RightArrow", mods="CTRL|SHIFT", action="DisableDefaultAssignment"},
    }
}
WindowsConfig = {
    default_prog = {"wsl.exe", "--cd", "~", "--exec", "/bin/zsh", "-l"},
    font = wezterm.font("FiraCode NF", {weight="Regular"}),
    font_size = 11.0,
}
LinuxConfig = {
    font = wezterm.font("FiraCode Nerd Font Mono", {weight="Regular"}),
    font_size = 12.0,
}

slash = package.config:sub(1,1)
if slash == '\\' then
    -- Possibly Windows
    to_merge = WindowsConfig
elseif slash == '/' then
    -- Linux
    to_merge = LinuxConfig
else
    to_merge = {}
end

for k,v in pairs(to_merge) do
    Config[k] = v
end

return Config

