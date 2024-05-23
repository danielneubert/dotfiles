-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration
local config = {}

-- Populate the configuration
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Set the cursor colors
config.colors = {
  cursor_fg = 'black',
  cursor_bg = '#F00045',
  cursor_border = '#F00045',
}

-- Set the cursor shape & config
config.cursor_blink_rate = 300
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.default_cursor_style = 'BlinkingBlock'

-- Make the window look like it has macOS translucency
config.window_background_opacity = 1

-- Return true if the macOS appearance is dark
local is_dark = function()
  local appearance = 'Dark'

  if wezterm.gui then
    appearance = wezterm.gui.get_appearance()
  end

  return appearance:find 'Dark'
end

-- Color scheme based on time of day
local function get_colorscheme()
  return 'duskfox'
end

-- Color scheme based on time of day
local function get_colors()
  return {
    selection_fg = 'Black',
    selection_bg = '#80B7FF',
    cursor_fg = 'black',
    cursor_bg = '#F00045',
    cursor_border = '#F00045',
    tab_bar = {
      background = '#191726',

      active_tab = {
        bg_color = '#4b4673',
        fg_color = '#eae8ff',
      },

      -- Inactive tabs are the tabs that do not have focus
      inactive_tab = {
        bg_color = '#2d2a45',
        fg_color = '#817c9c',
      },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over inactive tabs
      inactive_tab_hover = {
        bg_color = '#4b4673',
        fg_color = '#eae8ff',
      },

      -- The new tab button that let you create new tabs
      new_tab = {
        bg_color = '#191726',
        fg_color = '#817c9c',
      },

      new_tab_hover = {
        bg_color = '#4b4673',
        fg_color = '#eae8ff',
      },
    },
  }
end

-- Make the window perfect
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.scrollback_lines = 3500
config.tab_max_width = 40

-- Color scheme based on macOS appearance
config.color_scheme = get_colorscheme()
config.colors = get_colors()

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local label = ''
  local path = tab.active_pane.current_working_dir
  local process = string.gsub(tab.active_pane.foreground_process_name, '(.*[/\\])(.*)', '%2')
  local prefix = '[]'

  if path ~= nil then
    path = path.path

    if path ~= nil then
      path = path:gsub('/Users/' .. os.getenv 'USER' .. '/', '~/')
    end
  end

  prefix = '[' .. (tab.tab_index + 1)

  if process ~= nil and #process > 0 then
    if process == 'ssh' then
      path = '~~'
    end

    if process == 'fish' then
      process = nil
    end

    if process ~= nil then
      prefix = prefix .. '|' .. process
    end
  end

  prefix = prefix .. '] '

  if path ~= nil and #path > 0 then
    label = prefix .. path .. ' '
  else
    label = prefix
  end

  -- for loop with value 3, 2 and 1
  for i = 3, 1, -1 do
    if #label > 32 then
      local parts = {}

      for part in path:gmatch '[^/]+/' do
        local insertable = part:sub(1, i)

        -- insertable end with / like "~/" remove the slash
        if insertable:sub(-1) == '/' then
          insertable = insertable
        else
          insertable = insertable .. '/'
        end

        if #insertable > 1 then
          table.insert(parts, insertable)
        end
      end

      label = prefix .. table.concat(parts) .. path:match '[^/]+$' .. ' '
    end
  end

  return label
end)

config.window_decorations = 'TITLE|RESIZE|MACOS_FORCE_ENABLE_SHADOW'
config.exit_behavior = 'CloseOnCleanExit'
config.window_padding = {
  top = 2,
  left = 0,
  right = 0,
  bottom = 0,
}

-- Run the fish shell by default
-- This will enable to have the default zsh shell on the macos terminal for fallback cases
config.default_prog = { '/opt/homebrew/bin/fish' }

-- Just some font stuff
config.freetype_load_target = 'Normal'
config.font_size = 18
config.line_height = 1
config.font = wezterm.font {
  family = 'MonoLisa',
  stretch = 'Normal',
  harfbuzz_features = { 'zero', 'ss02', 'ss03', 'ss07', 'ss10', 'ss11', 'ss13', 'ss14', 'ss17' },
  weight = 500,
}

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
Bind('CMD', 't', wezterm.action { SpawnTab = 'CurrentPaneDomain' })
Bind('CMD', 'n', wezterm.action { SpawnTab = 'CurrentPaneDomain' })
Bind('CMD|SHIFT', 'q', wezterm.action { CloseCurrentPane = { confirm = false } })
Bind('CMD|SHIFT', 'w', wezterm.action { CloseCurrentTab = { confirm = false } })
Bind('CMD', 'j', wezterm.action.ActivateLastTab)
Bind('CMD', '1', wezterm.action { ActivateTab = 0 })
Bind('CMD', '2', wezterm.action { ActivateTab = 1 })
Bind('CMD', '3', wezterm.action { ActivateTab = 2 })
Bind('CMD', '4', wezterm.action { ActivateTab = 3 })
Bind('CMD', '5', wezterm.action { ActivateTab = 4 })

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
