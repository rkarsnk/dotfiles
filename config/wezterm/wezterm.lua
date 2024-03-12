local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config = {
    --default_prog = { 
    --  "/bin/zsh", 
    --  "-l",
    --  "-c",
    --  "tmux a -t default || tmux a -t base || tmux new -s base" },

    --# term 
    term = 'xterm-256color',

    --# color schema
    color_scheme = 'Argonaut',
    colors = {
        cursor_bg = "#FFFFFF",
        cursor_fg = "#000000",
    },
    -- default_cursor_style = "BlinkingBlock",
    
    --# column x row
    initial_rows = 70,
    initial_cols = 139,
    
    --# font config
    font = wezterm.font("Cica"),
    font_size = 18,
    
    --# hide tab bar 
    hide_tab_bar_if_only_one_tab = true,

    --# scroll bar
    enable_scroll_bar = true,
    
    --# window opacity
    window_background_opacity = 0.75,
    
    window_frame = {
    },

    window_padding = {
      left = 1,
      right = 1,
      top = 0,
      bottom = 0,
    },
    
    ssh_domains = {
      {
        name = 'pve',
        remote_address = 'pve.rkarsnk.net',
        username = 'rkarsnk',
      },
    },

}

return config
