local wezterm = require 'wezterm'

-- Color scheme based on time of day
local function get_colors()
  local colorBackground = '#000000'
  local colorActiveFg = '#7dcfff'
  local colorActiveBg = '#1a1b26'
  local colorOthersFg = '#737aa2'
  local colorOthersBg = '#000000'

  return {
    cursor_fg = 'black',
    cursor_bg = '#F00045',
    cursor_border = '#F00045',

    selection_fg = colorActiveFg,
    selection_bg = colorActiveBg,

    tab_bar = {
      background = colorBackground,

      active_tab = {
        fg_color = colorActiveFg,
        bg_color = colorActiveBg,
      },

      -- Inactive tabs are the tabs that do not have focus
      inactive_tab = {
        fg_color = colorOthersFg,
        bg_color = colorOthersBg,
      },
      inactive_tab_hover = {
        fg_color = colorOthersFg,
        bg_color = colorOthersBg,
      },

      -- The new tab button that let you create new tabs
      new_tab = {
        fg_color = colorBackground,
        bg_color = colorBackground,
      },
      new_tab_hover = {
        fg_color = colorBackground,
        bg_color = colorBackground,
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
