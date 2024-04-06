local wezterm = require("wezterm")
local config = {}

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 14.0

local keys = {
	{ key = "|", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- TODO: on new keyboard, change this to -
	{ key = "_", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
}

config.keys = keys

return config
