local wezterm = require 'wezterm'

require 'config/appearance'
require 'config/fonts'
require 'config/keybindings'

local config = wezterm.config_builder()

config.exit_behavior = 'Close'
config.default_prog = { '/opt/homebrew/bin/tmux' }

SetupAppearance(config)
SetupFonts(config)
SetupKeybindings(config)

return config
