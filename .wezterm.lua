local wezterm = require 'wezterm';

return {
    font = wezterm.font("FiraCode Nerd Font Mono", {weight="Regular"}),
    color_scheme = "Builtin Solarized Dark",
    hide_tab_bar_if_only_one_tab = true,
    window_padding = {
        left = 2,
        right = 2,
        top = 0,
        bottom = 0,
    },
    audible_bell = "Disabled",
}
