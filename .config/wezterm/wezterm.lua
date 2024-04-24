local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 14.0

config.disable_default_key_bindings = true
require("keymaps").apply_to_config(config)

config.quick_select_patterns = {
	-- TODO: debug why this path is not working
	"\b[[:alnum:]]+[.](?:c|cpp|py|lua|json|csv|ts|js|html|css|scss|md|sh|java|rs|go|zip|tar|pdf|xlsx|docx|pptx|txt|yml|yaml|toml|log|xml|sql|rb|php|dart)\b",
}

-- wezterm.lua

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config, {
	direction_keys = { "LeftArrow", "DownArrow", "UpArrow", "RightArrow" },
	-- direction_keys = { "h", "j", "k", "l" },
	modifiers = {
		move = "ALT",
		resize = "SHIFT|ALT",
	},
})

return config
