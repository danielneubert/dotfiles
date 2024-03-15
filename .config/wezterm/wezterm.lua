-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration
local config = {}

-- Populate the configuration
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Changing the cursor to something you'll see everywhere
config.colors = {
  cursor_bg = '#F00045',
  cursor_fg = 'black',
  -- cursor_bg = "#eb6f92",
  cursor_border = '#eb6f92',
}
config.window_background_opacity = 0.96
config.macos_window_background_blur = 48

-- Color scheme based on macOS appearance
config.color_scheme = 'rose-pine'

-- Make the window perfect
config.enable_tab_bar = false
config.window_decorations = 'TITLE|RESIZE|MACOS_FORCE_ENABLE_SHADOW'
config.exit_behavior = 'CloseOnCleanExit'
config.window_padding = {
  left = 0,
  right = 0,
  top = 2,
  bottom = 0,
}

config.cursor_blink_rate = 300
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.default_cursor_style = 'BlinkingBlock'

-- Run the fish shell by default
-- This will enable to have the default zsh shell on the macos terminal for fallback cases
config.default_prog = { '/opt/homebrew/bin/fish' }

config.freetype_load_target = 'Normal'

config.font_size = 18
config.line_height = 1
config.font = wezterm.font('Fira Code', { weight = 450, stretch = 'Normal', style = 'Normal' })

-- say that this macOS app works as a macOS app ...
config.native_macos_fullscreen_mode = true

-- start the macos screensaver and lockscreen via the shortcuts app
function StartLockscreen()
  return wezterm.action_callback(function(win, pane)
    wezterm.background_child_process {
      'shortcuts',
      'run',
      'Bildschirmschoner ein', -- DE: Screensaver on
    }
  end)
end

-- define keybindings
function Bind(mod, key, action)
  if config.keys == nil then
    config.keys = {}
  end

  config.keys[#config.keys + 1] = {
    key = key,
    mods = mod,
    action = action,
  }
end

-- disable the given keybinding and pass it down
function Disable()
  return wezterm.action.DisableDefaultAssignment
end

-- send the given keybinding
function SendKey(mod, key)
  return wezterm.action.SendKey { key = key, mods = mod }
end

-- disable some default bindings (to pass them down)
Bind('CMD', 'h', Disable())
Bind('CMD', 'm', Disable())
Bind('CMD', 'w', Disable())
Bind('CMD', 'q', Disable())
Bind('CTRL', 'n', Disable())
Bind('CTRL', 'w', Disable())
Bind('CTRL|SHIFT', 'j', Disable())
Bind('CTRL|SHIFT', 'k', Disable())

-- system bindings
Bind('CMD', 'F3', StartLockscreen())
Bind('CMD', 'F16', StartLockscreen())
Bind('CMD|CTRL', 'f', wezterm.action.ToggleFullScreen)

-- tmux bindings
Bind('CMD', 't', SendKey('CTRL', 'F6'))
Bind('CMD', 'n', SendKey('CTRL', 'F6'))
Bind('CMD|SHIFT', 'q', SendKey('CTRL', 'F7'))
Bind('CMD|SHIFT', 'w', SendKey('CTRL', 'F7'))
Bind('CMD|ALT|SHIFT', 'w', wezterm.action.CloseCurrentTab { confirm = true })
Bind('CMD', 'j', SendKey('CTRL', 'F8'))
Bind('CMD', 'k', SendKey('CTRL', 'F9'))
Bind('CMD', '1', SendKey('CTRL', 'F1'))
Bind('CMD', '2', SendKey('CTRL', 'F2'))
Bind('CMD', '3', SendKey('CTRL', 'F3'))
Bind('CMD', '4', SendKey('CTRL', 'F4'))
Bind('CMD', '5', SendKey('CTRL', 'F5'))

-- vim bindings
Bind('CMD', 'a', SendKey('CTRL', 'g')) -- visual mode select all
Bind('CMD', 'e', SendKey('CTRL', 'e')) -- open file explorer
Bind('CMD', 'f', SendKey('CTRL', 'p')) -- find file
Bind('CMD', 'l', SendKey('CTRL', 'p')) -- find file
Bind('CMD|SHIFT', 'l', SendKey('CTRL', 'k')) -- find file
Bind('CMD', 's', SendKey('CTRL', 's')) -- save file
Bind('CMD|SHIFT', 'f', SendKey('CTRL', 'f')) -- find filecontent
Bind('CMD|SHIFT', 'c', SendKey('CTRL', 'c')) -- copy vim selection to system clipboard

-- and finally, return the configuration to wezterm
return config
