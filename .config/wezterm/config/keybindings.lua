local wezterm = require 'wezterm'

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

-- send the given keybinding
function SendTmux(key)
    return wezterm.action.Multiple {
        SendKey('CTRL', 'A'),
        SendKey(nil, key),
    }
end

-- send the given keybinding
function SendVim(key)
    return wezterm.action.Multiple {
        SendKey('CTRL', 'W'),
        SendKey(nil, key),
    }
end

function SetupKeybindings(config)
    -- disable default bindings
    Bind(config, 'CMD', 'h', Disable())
    Bind(config, 'CMD', 'm', Disable())
    Bind(config, 'CMD', 'w', Disable())
    Bind(config, 'CMD', 'q', Disable())
    Bind(config, 'CTRL', 'n', Disable())
    Bind(config, 'CTRL', 'w', Disable())
    Bind(config, 'ALT', 'Enter', Disable())
    Bind(config, 'CTRL|SHIFT', 'j', Disable())
    Bind(config, 'CTRL|SHIFT', 'k', Disable())

    -- system bindings
    Bind(config, 'CMD', '+', wezterm.action.IncreaseFontSize)
    Bind(config, 'CMD|CTRL', 'f', wezterm.action.ToggleFullScreen)
    Bind(config, 'CMD', 'n', wezterm.action.SpawnCommandInNewWindow {})
    Bind(config, 'CMD', 'F3', wezterm.action_callback(function(_, __)
        wezterm.background_child_process {
            'shortcuts',
            'run',
            'Bildschirm sperren',
        }
    end))

    -- tmux bindings
    Bind(config, 'CMD|SHIFT', 'w', SendTmux('w'))
    Bind(config, 'CMD', 't', SendTmux('t'))
    Bind(config, 'CMD', '1', SendTmux('1'))
    Bind(config, 'CMD', '2', SendTmux('2'))
    Bind(config, 'CMD', '3', SendTmux('3'))
    Bind(config, 'CMD', '4', SendTmux('4'))
    Bind(config, 'CMD', '5', SendTmux('5'))
    Bind(config, 'CMD', '6', SendTmux('6'))
    Bind(config, 'CMD', '7', SendTmux('7'))
    Bind(config, 'CMD', '8', SendTmux('8'))
    Bind(config, 'CMD', '9', SendTmux('9'))
    Bind(config, 'CMD', ',', SendTmux('i'))

    -- vim bindings
    Bind(config, 'CMD', 'a', SendKey('CTRL', 'g'))
    Bind(config, 'CMD', 'e', SendKey('CTRL', 'e'))
    Bind(config, 'CMD', 'l', SendKey('CTRL', 'p'))
    Bind(config, 'CMD', 's', SendKey('CTRL', 's'))
    Bind(config, 'CMD|SHIFT', 'c', SendKey('CTRL', 'c'))

    -- vim rebindings
    Bind(config, 'CTRL', 'h', SendVim('h'))
    Bind(config, 'CTRL', 'j', SendVim('j'))
    Bind(config, 'CTRL', 'k', SendVim('k'))
    Bind(config, 'CTRL', 'l', SendVim('l'))
    Bind(config, 'CTRL', 'H', SendVim('H'))
    Bind(config, 'CTRL', 'L', SendVim('L'))
    Bind(config, 'CTRL', 'W', SendVim('W'))
end
