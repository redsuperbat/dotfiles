local wezterm = require("wezterm")

-- Always open in full screen mode
wezterm.on("update-status", function(window)
	if not window:get_dimensions().is_full_screen then
		window:toggle_fullscreen()
	end
end)

local act = wezterm.action
local config = {}
-- Use config builder if available
if wezterm.config_builder then
	config = wezterm.config_builder()
end
config.keys = {}
-- Default hyperlinks so they are clickable
config.hyperlink_rules = wezterm.default_hyperlink_rules()

config.force_reverse_video_cursor = true
config.colors = {
	foreground = "#dcd8ba",
	background = "#1f1f28",

	cursor_bg = "#c8c093",
	cursor_fg = "#c8c093",
	cursor_border = "#c8c093",

	selection_fg = "#c8c093",
	selection_bg = "#2d4f67",

	scrollbar_thumb = "#16161d",
	split = "#16161d",

	ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
	brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
	indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
}

local keybind = function(key, mod, action)
	table.insert(config.keys, { key = key, mods = mod, action = action })
end

config.default_prog = {
	"/opt/homebrew/bin/tmux",
	"new-session",
	"-A",
	"-s",
	"main",
	"-c",
	"~",
}
config.window_padding = {
	left = 0,
	right = 0,
	top = 30,
	bottom = 0,
}
config.window_decorations = "NONE"
config.enable_tab_bar = false

-- Eu keyboards
keybind("(", "ALT|SHIFT", act.SendString("{"))
keybind(")", "ALT|SHIFT", act.SendString("}"))
keybind("/", "ALT|SHIFT", act.SendString("\\"))
keybind("v", "ALT|SHIFT", act.ActivateCopyMode)

-- Font size
keybind("-", "CMD", act.DecreaseFontSize)
keybind("+", "CMD", act.IncreaseFontSize)
keybind("0", "CMD", act.ResetFontSize)

-- Toggle fullscreen event
keybind("e", "ALT|SHIFT", act.ToggleFullScreen)

return config
