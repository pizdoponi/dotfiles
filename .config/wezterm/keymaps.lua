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
	{ key = "LeftArrow", mods = "SHIFT|SUPER", action = wezterm.action.MoveTabRelative(-1) },
	{ key = "RightArrow", mods = "SHIFT|SUPER", action = wezterm.action.MoveTabRelative(1) },
	-- panes
	{ key = "%", mods = "SUPER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = '"', mods = "SUPER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "LeftArrow", mods = "SUPER", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "SUPER", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "SUPER", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "SUPER", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "w", mods = "SHIFT|SUPER", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
	-- copy and paste
	{ key = "c", mods = "SUPER", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "v", mods = "SUPER", action = wezterm.action.PasteFrom("Clipboard") },
	-- yanking
	{ key = "y", mods = "SUPER", action = wezterm.action.QuickSelect },
	{ key = "c", mods = "SHIFT|SUPER", action = wezterm.action.ActivateCopyMode },
	-- font size
	{ key = "-", mods = "SUPER", action = wezterm.action.DecreaseFontSize },
	{ key = "+", mods = "SUPER", action = wezterm.action.IncreaseFontSize },
	{ key = "0", mods = "SUPER", action = wezterm.action.ResetFontSize },
	-- misc
	{ key = "p", mods = "SHIFT|SUPER", action = wezterm.action.ActivateCommandPalette },
	{ key = "f", mods = "SUPER|CTRL", action = wezterm.action.ToggleFullScreen },
	{ key = "z", mods = "SUPER", action = wezterm.action.TogglePaneZoomState },
	{ key = "m", mods = "SUPER", action = wezterm.action.Hide },
	-- proper key emulation
	{ key = "b", mods = "ALT", action = wezterm.action({ SendString = "\x1bb" }) },
	{ key = "f", mods = "ALT", action = wezterm.action({ SendString = "\x1bf" }) },
	{ key = "t", mods = "ALT", action = wezterm.action({ SendString = "\x1bt" }) },
	{ key = "s", mods = "ALT", action = wezterm.action({ SendString = "\x1bs" }) },
	{ key = "a", mods = "ALT", action = wezterm.action({ SendString = "\x1ba" }) },
	{ key = "d", mods = "ALT", action = wezterm.action({ SendString = "\x1bd" }) },
}

function M.apply_to_config(config)
	config.keys = keys
end

return M
