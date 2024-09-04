local wezterm = require 'wezterm'

-- start the macos screensaver and lockscreen via the shortcuts app
function StartLockscreen()
  return wezterm.action_callback(function(win, pane)
    wezterm.background_child_process {
      'shortcuts',
      'run',
      'Bildschirm sperren (Ergo)',
    }
  end)
end

function Bind(config, mod, key, action)
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

function SetupKeybindings(config)
  -- disable default bindings
  Bind(config, 'CMD', 'h', Disable())
  Bind(config, 'CMD', 'm', Disable())
  Bind(config, 'CMD', 'w', Disable())
  Bind(config, 'CMD', 'q', Disable())
  Bind(config, 'CTRL', 'n', Disable())
  Bind(config, 'CTRL', 'w', Disable())
  Bind(config, 'CTRL|SHIFT', 'j', Disable())
  Bind(config, 'CTRL|SHIFT', 'k', Disable())

  -- system bindings
  Bind(config, 'CMD', 'F3', StartLockscreen())
  Bind(config, 'CMD', 'F16', StartLockscreen())
  Bind(config, 'CMD|CTRL', 'f', wezterm.action.ToggleFullScreen)

  -- pane and tab bindings
  Bind(config, 'CMD', 't', wezterm.action { SpawnTab = 'CurrentPaneDomain' })
  Bind(config, 'CMD', 'n', wezterm.action { SpawnTab = 'CurrentPaneDomain' })
  Bind(config, 'CMD|SHIFT', 'w', wezterm.action { CloseCurrentTab = { confirm = false } })
  Bind(config, 'CMD|ALT', 'v', wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' })
  Bind(config, 'CMD|ALT', 'c', wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' })
  Bind(config, 'CMD|ALT', 'w', wezterm.action { CloseCurrentPane = { confirm = false } })
  Bind(config, 'CMD|ALT', 'p', wezterm.action.PaneSelect { alphabet = '1234567890' })
  Bind(config, 'CMD', 'j', wezterm.action.ActivateLastTab)
  Bind(config, 'CMD', '1', wezterm.action { ActivateTab = 0 })
  Bind(config, 'CMD', '2', wezterm.action { ActivateTab = 1 })
  Bind(config, 'CMD', '3', wezterm.action { ActivateTab = 2 })
  Bind(config, 'CMD', '4', wezterm.action { ActivateTab = 3 })
  Bind(config, 'CMD', '5', wezterm.action { ActivateTab = 4 })

  -- vim bindings
  Bind(config, 'CMD', 'a', SendKey('CTRL', 'g')) -- select all
  Bind(config, 'CMD', 'e', SendKey('CTRL', 'e')) -- open file explorer
  Bind(config, 'CMD', 'l', SendKey('CTRL', 'p')) -- find file
  Bind(config, 'CMD', 's', SendKey('CTRL', 's')) -- save file
  Bind(config, 'CMD|SHIFT', 'c', SendKey('CTRL', 'c')) -- copy vim selection to system clipboard
end
