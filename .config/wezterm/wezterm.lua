local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("appearance").apply_to_config(config)

config.disable_default_key_bindings = true
require("keymaps").apply_to_config(config)

require("yanking").apply_to_config(config)

config.max_fps = 240

return config
