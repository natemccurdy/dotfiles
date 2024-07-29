local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- General
config.automatically_reload_config = true
config.native_macos_fullscreen_mode = true
config.initial_cols = 95 -- width, in cells
config.initial_rows = 26 -- height, in cells

-- TMUX-like leader: ctrl+a
-- I use capslock which is mapped to ctrl in the OS.
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1500 }

-- Style
config.color_scheme = "GruvboxDark"
config.default_cursor_style = "BlinkingUnderline"
config.font = wezterm.font("MesloLGS Nerd Font")
config.font_size = 13.5
config.window_decorations = "RESIZE"
config.window_padding = {
	-- left = "0.2cell",
	-- right = "0.2cell",
	top = "0.8cell",
	bottom = "0.8cell",
}

-- Tabs
config.hide_tab_bar_if_only_one_tab = true
config.show_close_tab_button_in_tabs = false
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true
-- With the fancy tab bar, font and background are set in config.window_frame.
config.window_frame = {
	-- The font used in the tab bar.
	font = wezterm.font("MesloLGS Nerd Font", { weight = "Bold" }),
	-- The size of the font in the tab bar.
	font_size = 12.0,
	active_titlebar_bg = "rgba(0,0,0,0)",
}
config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = "rgba(0,0,0,0)",
			fg_color = "#fb4934", -- gruvbox red
		},
		inactive_tab = {
			bg_color = "rgba(0,0,0,0)",
			fg_color = "#666666",
		},
		inactive_tab_edge = "rgba(0,0,0,0)",
	},
}

-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window, _)
	local name = window:active_key_table()
	if name then
		name = "TABLE: " .. name
	end
	window:set_right_status(name or "")
end)

-- Keybindings (very tmux-like)
config.keys = {
	-- Make ctrl+a move cursor to start of line. Use "<leader>+a a".
	{ key = "a", mods = "LEADER", action = act.SendKey({ key = "a", mods = "CTRL" }) },
	{ key = "c", mods = "LEADER", action = act.SpawnCommandInNewTab({ cwd = wezterm.home_dir }) },
	{ key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "H", mods = "LEADER", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "J", mods = "LEADER", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "K", mods = "LEADER", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "L", mods = "LEADER", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
	{ key = "1", mods = "LEADER", action = act.ActivateTab(0) },
	{ key = "2", mods = "LEADER", action = act.ActivateTab(1) },
	{ key = "3", mods = "LEADER", action = act.ActivateTab(2) },
	{ key = "4", mods = "LEADER", action = act.ActivateTab(3) },
	{ key = "5", mods = "LEADER", action = act.ActivateTab(4) },
	{ key = "6", mods = "LEADER", action = act.ActivateTab(5) },
	{ key = "7", mods = "LEADER", action = act.ActivateTab(6) },
	{ key = "8", mods = "LEADER", action = act.ActivateTab(7) },
	{ key = "9", mods = "LEADER", action = act.ActivateTab(8) },
	{
		key = ",",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Rename tab:",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false, timeout_milliseconds = 1000 }),
	},
}

config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},
}

return config
