local wezterm = require("wezterm")
local M = {}

M.apply_to_config = function(config)
	config.color_scheme = "Catppuccin Mocha"
	-- config.font = wezterm.font("Hack Nerd Font Mono")
	-- config.font = wezterm.font("MesloLGL Nerd Font Mono")
	config.font = wezterm.font("JetBrainsMono Nerd Font")
	config.font_size = 14.0

	config.enable_tab_bar = true
	config.use_fancy_tab_bar = true
	config.hide_tab_bar_if_only_one_tab = true
	config.tab_bar_at_bottom = false

	-- config.window_background_image = "/Users/rok/Downloads/cyber_girl.jpg"
end

return M
