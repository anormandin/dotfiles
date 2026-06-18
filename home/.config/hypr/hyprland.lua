-- ~/.config/hypr/hyprland.lua
-- Hyprland 0.55 Lua config for archdev (RTX 4070 Ti SUPER, DP-2 1440p@144).
-- Migrated from the old hyprlang hyprland.conf. Docs: 0.55+ uses Lua + the `hl` API.

----------------------------------------------------------------------
-- Variables (just Lua locals now -- no more $mod)
----------------------------------------------------------------------
local mod      = "SUPER"                -- Windows/Cmd-position key. Set "ALT" for the old dwm feel.
local terminal = "alacritty"
local menu     = "wofi --show drun"

----------------------------------------------------------------------
-- Monitor
----------------------------------------------------------------------
hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

----------------------------------------------------------------------
-- Environment (NVIDIA + toolkit Wayland hints)
----------------------------------------------------------------------
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("XCURSOR_SIZE", "24")

----------------------------------------------------------------------
-- Look & feel
----------------------------------------------------------------------
hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 8,
    border_size = 2,
    layout = "dwindle",
    resize_on_border = true,
    col = {
      active_border = "rgba(458588ff)",
      inactive_border = "rgba(504945ff)",
    },
  },

  decoration = {
    rounding = 6,
    blur = { enabled = true, size = 3, passes = 1 },
    shadow = { enabled = false },
  },

  -- Defaults give pleasant animations; just keep them on.
  animations = { enabled = true },

  -- dwindle = binary-split tiling (BSP-like). New window splits the focused one.
  -- Toggle split direction with mod+S. pseudotile is now the pseudo dispatcher (mod+P).
  dwindle = { preserve_split = true },

  input = {
    kb_layout = "us",
    follow_mouse = 1,
    sensitivity = 0,
  },

  misc = {
    disable_hyprland_logo = true,
    force_default_wallpaper = 0,
  },
})

----------------------------------------------------------------------
-- Autostart
----------------------------------------------------------------------
hl.on("hyprland.start", function()
  hl.exec_cmd("waybar")
  hl.exec_cmd("swaybg -c 282828")
  hl.exec_cmd("dunst")
  hl.exec_cmd("wl-paste --watch cliphist store")
  -- Polkit agent: import the Wayland env into the systemd user manager FIRST
  -- (start-hyprland doesn't activate graphical-session.target), then start it.
  -- Chained with && so the service never starts before its env exists -- without
  -- this it core-dumps and trips the systemd restart limit.
  hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP "
    .. "&& systemctl --user reset-failed hyprpolkitagent.service "
    .. "&& systemctl --user start hyprpolkitagent.service")
end)

----------------------------------------------------------------------
-- Keybindings
----------------------------------------------------------------------
-- Launchers / window management
hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + D",      hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + Q",      hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(mod .. " + V",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + F",      hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mod .. " + P",      hl.dsp.window.pseudo({ action = "toggle" }))
hl.bind(mod .. " + S",      hl.dsp.layout("togglesplit"))  -- flip dwindle split direction
hl.bind(mod .. " + B",      hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))

-- Move focus (vim keys + arrows)
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + LEFT",  hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + RIGHT", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + UP",    hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + DOWN",  hl.dsp.focus({ direction = "d" }))

-- Move the window itself
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

-- Resize the focused window
hl.bind(mod .. " + CTRL + H", hl.dsp.window.resize({ x = -40, y = 0, relative = true }))
hl.bind(mod .. " + CTRL + L", hl.dsp.window.resize({ x = 40,  y = 0, relative = true }))
hl.bind(mod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -40, relative = true }))
hl.bind(mod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = 40,  relative = true }))

-- Workspaces 1-10 (the macOS-Spaces analog) -- generated in a loop
for i = 1, 10 do
  local key = (i == 10) and "0" or tostring(i)
  hl.bind(mod .. " + " .. key,          hl.dsp.focus({ workspace = i }))
  hl.bind(mod .. " + SHIFT + " .. key,  hl.dsp.window.move({ workspace = i }))
end

-- Cycle workspaces with scroll
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Mouse drag move/resize (hold mod)
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize())

-- Screenshot region -> clipboard
hl.bind("PRINT", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))

-- Media / volume / brightness keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),        { repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),       { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 10%+"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { repeating = true })

----------------------------------------------------------------------
-- Window rules
----------------------------------------------------------------------
hl.window_rule({ name = "float-gimp",      match = { class = "^Gimp$" },     float = true })
hl.window_rule({ name = "float-open-file", match = { title = "^Open File$" }, float = true })
