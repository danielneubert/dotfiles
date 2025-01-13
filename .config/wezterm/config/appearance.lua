function SetupAppearance(config)
  -- Colors
  config.color_scheme = 'Night Owl (Gogh)'

  -- Set the cursor colors
  config.colors = {
    cursor_fg = '#000000',
    cursor_bg = '#ff375f',
  }

  -- Cursor
  config.cursor_blink_ease_in = 'Constant'
  config.cursor_blink_ease_out = 'Constant'
  config.cursor_blink_rate = 500
  config.cursor_thickness = '0.075cell'
  config.default_cursor_style = 'BlinkingBlock'

  -- Disable Tabs
  config.enable_tab_bar = false

  -- Design
  config.max_fps = 120
  config.scrollback_lines = 1000
  config.native_macos_fullscreen_mode = true
  config.window_decorations = 'TITLE|RESIZE|MACOS_FORCE_ENABLE_SHADOW'
  config.window_padding = {
    top = 8,
    left = 8,
    right = 0,
    bottom = 0,
  }
end
