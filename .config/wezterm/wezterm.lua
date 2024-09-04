local wezterm = require 'wezterm'

require 'config/appearance'
require 'config/fonts'
require 'config/keybindings'
require 'config/tabbar'

-- get the config builder setup
local config = wezterm.config_builder()

-- exit the terminal after a process has exited
config.exit_behavior = 'Close'

-- set the default shell to fish
config.default_prog = { '/opt/homebrew/bin/fish' }

-- setup the important parts of the configuration
SetupAppearance(config)
SetupFonts(config)
SetupKeybindings(config)
SetupTabbar(config)

-- here you go
return config
