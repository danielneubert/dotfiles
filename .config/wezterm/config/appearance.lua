function SetupAppearance(config)
  -- Set the cursor shape & config
  config.cursor_blink_ease_in = 'Constant'
  config.cursor_blink_ease_out = 'Constant'
  config.cursor_blink_rate = 200
  config.default_cursor_style = 'BlinkingBlock'

  -- Style the window
  config.enable_tab_bar = true
  config.native_macos_fullscreen_mode = true
  config.scrollback_lines = 3500
  config.tab_bar_at_bottom = true
  config.tab_max_width = 50
  config.use_fancy_tab_bar = false
  config.window_background_opacity = 0.925
  config.macos_window_background_blur = 48
  config.window_decorations = 'TITLE|RESIZE|MACOS_FORCE_ENABLE_SHADOW'
  config.window_padding = {
    top = 2,
    left = 2,
    right = 2,
    bottom = 2,
  }

  -- Colors
  config.color_scheme = 'Tokyo Night Storm'
end
