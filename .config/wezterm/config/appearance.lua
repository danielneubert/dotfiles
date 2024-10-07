function SetupAppearance(config)
  -- Set the cursor shape & config
  config.cursor_blink_ease_in = 'Constant'
  config.cursor_blink_ease_out = 'Constant'
  config.cursor_blink_rate = 250
  config.default_cursor_style = 'SteadyBlock'

  -- Tab Bar
  config.enable_tab_bar = true
  config.tab_bar_at_bottom = true
  config.tab_max_width = 50
  config.use_fancy_tab_bar = false

  -- Style the window
  config.macos_window_background_blur = 100
  config.native_macos_fullscreen_mode = true
  config.scrollback_lines = 5000
  config.window_background_opacity = 0.85
  config.window_decorations = 'TITLE|RESIZE|MACOS_FORCE_ENABLE_SHADOW'
  config.window_padding = {
    top = 0,
    left = 0,
    right = 0,
    bottom = 0,
  }

  -- Colors
  config.color_scheme = 'Tokyo Night Moon'
end
