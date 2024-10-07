local wezterm = require 'wezterm'

local function get_colors()
  local colorActiveBg = '#222436'
  local colorActiveFg = '#86e1fc'
  local colorOthersFg = '#636da6'
  local colorSelectFg = '#c8d3f5'

  return {
    cursor_fg = 'black',
    cursor_bg = '#F00045',
    cursor_border = '#F00045',

    selection_fg = colorSelectFg,
    selection_bg = colorOthersFg,

    tab_bar = {
      background = 'black',

      active_tab = {
        fg_color = colorActiveFg,
        bg_color = colorActiveBg,
      },

      inactive_tab = {
        fg_color = colorOthersFg,
        bg_color = 'black',
      },
      inactive_tab_hover = {
        fg_color = colorOthersFg,
        bg_color = 'black',
      },

      new_tab = {
        fg_color = 'black',
        bg_color = 'black',
      },
      new_tab_hover = {
        fg_color = 'black',
        bg_color = 'black',
      },
    },
  }
end

function SetupTabbar(config)
  config.colors = get_colors()
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local path = tab.active_pane.current_working_dir
  local process = string.gsub(tab.active_pane.foreground_process_name, '(.*[/\\])(.*)', '%2')

  local labels = {
    [0] = "󰎦 ",
    [1] = "󰎩 ",
    [2] = "󰎬 ",
    [3] = "󰎮 ",
    [4] = "󰎰 ",
    [5] = "󰎵 ",
    [6] = "󰎸 ",
    [7] = "󰎻 ",
    [8] = "󰎾 "
  }

  if process ~= nil and #process > 0 then
    if process == 'fish' then
      process = nil
    end
  end

  -- if tab.tab_index < 9, use the label otherwise add 1 and make it the laabel
  local prefix = labels[tab.tab_index] or '󰲲 '
  prefix = ' ' .. prefix .. ' '

  if process == nil and path ~= nil then
    return prefix .. path.path:match(".*/(.+)$") .. ' '
  end

  return prefix .. process .. ' '
end)
