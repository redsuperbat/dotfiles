local wezterm = require("wezterm")

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
	"tmux",
	"-c",
	"~",
}
config.window_padding = {
	left = 0,
	right = 0,
	top = 30,
	bottom = 0,
}

-- Eu keyboards
keybind("(", "ALT|SHIFT", act.SendString("{"))
keybind(")", "ALT|SHIFT", act.SendString("}"))
keybind("/", "ALT|SHIFT", act.SendString("\\"))
keybind("v", "LEADER", act.ActivateCopyMode)

-- Font size
keybind("-", "CMD", act.DecreaseFontSize)
keybind("+", "CMD", act.IncreaseFontSize)
keybind("0", "CMD", act.ResetFontSize)

return config
