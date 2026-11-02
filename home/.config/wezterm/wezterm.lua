local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()
local is_macos = wezterm.target_triple:find("darwin")
local is_windows = wezterm.target_triple:find("windows")

-- Color scheme: current theme from ~/.config/theme-current (managed by the
-- `theme` CLI), falling back to the vendored Kanagawa if no theme is set.
local theme_file = wezterm.home_dir .. "/.config/theme-current/wezterm.lua"
if is_windows then
	-- No stow on Windows: read the theme straight from the repo. Git checks the
	-- theme-current symlink out as a one-line text file holding its target
	-- (core.symlinks=false), so follow it by hand.
	local theme_dir = wezterm.home_dir .. "/dotfiles/home/.config/theme-current"
	theme_file = theme_dir .. "/wezterm.lua"
	local stub = io.open(theme_file)
	if stub then
		local target = stub:read("*l")
		stub:close()
		if target and target:match("^[%w%._/-]+%.lua$") then
			theme_file = theme_dir .. "/" .. target
		end
	end
end
local ok, theme = pcall(dofile, theme_file)
if not ok then
	theme = require("colors.kanagawa")
	theme.gradient = { "#363646", "#1f1f28", "#16161d" }
end
-- Watch the REAL paths inside the stow repo: the ~/.config ones are symlinks,
-- and macOS file events don't fire across them (`theme set` repoints the
-- theme-current/wezterm.lua symlink, which is a dir-entry change in the repo).
wezterm.add_to_config_reload_watch_list(theme_file)
wezterm.add_to_config_reload_watch_list(wezterm.home_dir .. "/dotfiles/home/.config/theme-current")
wezterm.add_to_config_reload_watch_list(wezterm.home_dir .. "/dotfiles/home/.config/theme-current/wezterm.lua")
wezterm.add_to_config_reload_watch_list(wezterm.home_dir .. "/dotfiles/home/.config/wezterm/wezterm.lua")
config.color_schemes = { ["Theme"] = theme.colors }
config.color_scheme = "Theme"
config.force_reverse_video_cursor = theme.force_reverse_video_cursor
config.bold_brightens_ansi_colors = "No"

-- Window appearance
config.window_background_opacity = 0.8
config.macos_window_background_blur = 40
config.window_background_gradient = {
	orientation = "Vertical",
	-- raised surface → terminal bg → deep bg (per-theme, from theme-current)
	colors = theme.gradient,
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
-- Per-theme font (palette `font` key), with Hack Nerd as glyph fallback
config.font = wezterm.font_with_fallback({ theme.font or "Hack Nerd Font Mono", "Hack Nerd Font Mono" })
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

-- Modifiers: Cmd on macOS. On Windows the Win key is taken by the OS
-- (Win+V clipboard history, Win+K cast, ...), so use Ctrl+Shift instead,
-- and plain Ctrl for font size (Ctrl+Shift+= types "+").
local mod = "SUPER"
local mod_shift = "SUPER|SHIFT"
local size_mod = "SUPER"
-- Edit config in nvim; on Windows nvim lives in WSL, so open it there.
local edit_config = act.SpawnCommandInNewTab({
	cwd = wezterm.home_dir,
	args = { "nvim", wezterm.config_file },
})
if is_windows then
	mod = "CTRL|SHIFT"
	mod_shift = "CTRL|SHIFT"
	size_mod = "CTRL"
	local wsl_config_path = wezterm.config_file:gsub("\\", "/"):gsub("^(%a):", function(drive)
		return "/mnt/" .. drive:lower()
	end)
	edit_config = act.SpawnCommandInNewTab({
		domain = { DomainName = "WSL:Ubuntu" },
		args = { "nvim", wsl_config_path },
	})

	-- Shell: Windows PowerShell by default, Ubuntu (WSL) one key away.
	config.default_prog = { "powershell.exe", "-NoLogo" }
	config.launch_menu = {
		{ label = "PowerShell", args = { "powershell.exe", "-NoLogo" } },
		{ label = "Ubuntu (WSL)", domain = { DomainName = "WSL:Ubuntu" } },
	}
end

config.keys = {
	-- Shift+Enter sends Esc+Enter (useful for vi mode in shells/REPLs)
	{ key = "Enter", mods = "SHIFT", action = act.SendString("\x1b\r") },
	{ key = ",", mods = mod, action = edit_config },
	{ key = "r", mods = mod_shift, action = act.ReloadConfiguration },
	{ key = "k", mods = mod, action = act.ClearScrollback("ScrollbackAndViewport") },
	{ key = "Enter", mods = mod, action = act.ToggleFullScreen },
	-- Font size
	{ key = "=", mods = size_mod, action = act.IncreaseFontSize },
	{ key = "-", mods = size_mod, action = act.DecreaseFontSize },
	{ key = "0", mods = size_mod, action = act.ResetFontSize },
	-- Copy / paste
	{ key = "c", mods = mod, action = act.CopyTo("Clipboard") },
	{ key = "v", mods = mod, action = act.PasteFrom("Clipboard") },
}
if is_windows then
	-- New tab in Ubuntu (WSL); Ctrl+Shift+T stays PowerShell.
	table.insert(config.keys, {
		key = "u",
		mods = "CTRL|SHIFT",
		action = act.SpawnCommandInNewTab({ domain = { DomainName = "WSL:Ubuntu" } }),
	})
	table.insert(config.keys, { key = "l", mods = "ALT", action = act.ShowLauncher })
end

config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act.PasteFrom("Clipboard"),
	},
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = is_windows and "CTRL" or "SUPER",
		action = act.OpenLinkAtMouseCursor,
	},
}

return config
