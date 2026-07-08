local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()
local is_macos = wezterm.target_triple:find("darwin")

-- Color scheme: custom Kanagawa loaded from colors/kanagawa.lua
local kanagawa = require("colors.kanagawa")
config.color_schemes = { ["Kanagawa"] = kanagawa.colors }
config.color_scheme = "Kanagawa"
config.force_reverse_video_cursor = kanagawa.force_reverse_video_cursor
config.bold_brightens_ansi_colors = "No"

-- Window appearance
config.window_background_opacity = 0.8
config.macos_window_background_blur = 40
config.window_background_gradient = {
	orientation = "Vertical",
	-- Kanagawa sumi-ink scale: sumiInk3 → sumiInk1 (terminal bg) → sumiInk0
	colors = { "#363646", "#1f1f28", "#16161d" },
	interpolation = "CatmullRom",
	blend = "Oklab",
	-- 0 = no dithering grain (default adds noise, which looks grainy here)
	noise = 0,
}
config.window_decorations = "TITLE|RESIZE"
config.native_macos_fullscreen_mode = true
if is_macos then
	config.window_padding = { left = 24, right = 24, top = 14, bottom = 10 }
else
	config.window_padding = { left = 6, right = 6, top = 4, bottom = 2 }
end

-- Font
config.font = wezterm.font_with_fallback({ "Hack Nerd Font Mono" })
-- macOS renders points at 72 DPI, Linux at 96 — the same size looks ~1.33x larger on Linux
if is_macos then
	config.font_size = 16
else
	config.font_size = 12
end
config.line_height = 1.1
config.adjust_window_size_when_changing_font_size = false

-- Cursor
config.default_cursor_style = "SteadyBlock"
config.cursor_blink_rate = 0

-- Tab bar (minimal, tmux-style)
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32

-- Performance / rendering
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.max_fps = 120
config.animation_fps = 60

-- Bell
config.audible_bell = "Disabled"

-- Scrollback
config.scrollback_lines = 10000

config.keys = {
	-- Shift+Enter sends Esc+Enter (useful for vi mode in shells/REPLs)
	{ key = "Enter", mods = "SHIFT", action = act.SendString("\x1b\r") },
	-- Edit config
	{
		key = ",",
		mods = "SUPER",
		action = act.SpawnCommandInNewTab({
			cwd = wezterm.home_dir,
			args = { "nvim", wezterm.config_file },
		}),
	},
	{ key = "r", mods = "SUPER|SHIFT", action = act.ReloadConfiguration },
	{ key = "k", mods = "SUPER", action = act.ClearScrollback("ScrollbackAndViewport") },
	{ key = "Enter", mods = "SUPER", action = act.ToggleFullScreen },
	-- Font size
	{ key = "=", mods = "SUPER", action = act.IncreaseFontSize },
	{ key = "-", mods = "SUPER", action = act.DecreaseFontSize },
	{ key = "0", mods = "SUPER", action = act.ResetFontSize },
	-- Copy / paste
	{ key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
}

config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act.PasteFrom("Clipboard"),
	},
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "SUPER",
		action = act.OpenLinkAtMouseCursor,
	},
}

return config
