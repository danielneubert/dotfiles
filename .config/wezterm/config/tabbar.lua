local wezterm = require 'wezterm'

-- Color scheme based on time of day
local function get_colors()
  local colorBackground = '#1e1e2e'
  local colorActiveFg = '#181825'
  local colorActiveBg = '#b4befe'
  local colorOthersFg = '#9399b2'
  local colorOthersBg = '#45475a'

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

    -- if process ~= nil then
    --   prefix = prefix .. '|' .. process
    -- end
  end

  prefix = prefix .. '] '

  if process ~= nil then
    prefix = prefix .. process .. ' • '
  end

  if path ~= nil and #path > 0 then
    label = prefix .. path .. ' '
  else
    label = prefix
  end

  -- for loop with value 3, 2 and 1
  for i = 3, 1, -1 do
    if #label > 40 then
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
