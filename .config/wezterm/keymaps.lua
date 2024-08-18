local wezterm = require("wezterm")
local M = {}

local keys = {
	-- windows
	{ key = "n", mods = "SUPER", action = wezterm.action.SpawnWindow },
	-- tabs
	{ key = "t", mods = "SUPER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "SUPER", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
	{ key = "Tab", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "1", mods = "SUPER", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "SUPER", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "SUPER", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "SUPER", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "SUPER", action = wezterm.action.ActivateTab(4) },
	{ key = "6", mods = "SUPER", action = wezterm.action.ActivateTab(5) },
	{ key = "7", mods = "SUPER", action = wezterm.action.ActivateTab(6) },
	{ key = "8", mods = "SUPER", action = wezterm.action.ActivateTab(7) },
	{ key = "9", mods = "SUPER", action = wezterm.action.ActivateTab(8) },
	{ key = "0", mods = "SUPER", action = wezterm.action.ActivateTab(9) },
	-- panes
	{ key = "%", mods = "SUPER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = '"', mods = "SUPER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- copy and paste
	{ key = "c", mods = "SUPER", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "v", mods = "SUPER", action = wezterm.action.PasteFrom("Clipboard") },
	-- { key = "c", mdos = "CTRL|SHIFT", action = wezterm.action.QuickSelect },
	-- yanking
	{ key = "y", mods = "SUPER", action = wezterm.action.QuickSelect },
	-- misc
	{ key = "p", mods = "SUPER", action = wezterm.action.ActivateCommandPalette },
	{ key = "-", mods = "SUPER", action = wezterm.action.DecreaseFontSize },
	{ key = "+", mods = "SUPER", action = wezterm.action.IncreaseFontSize },
}

function M.apply_to_config(config)
	config.keys = keys
end

return M
