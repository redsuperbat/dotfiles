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
config.term = "alacritty"

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
