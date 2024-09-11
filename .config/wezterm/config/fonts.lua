local wezterm = require 'wezterm'

function SetupFonts(config)
  config.freetype_load_target = 'Normal'
  config.font_size = 16
  config.line_height = 1.1
  config.font_rules = {
    {
      font = wezterm.font {
        family = 'ComicCodeLigatures',
        stretch = 'Normal',
        harfbuzz_features = { 'ss19' },
        weight = 500,
        italic = false,
      },
    },
  }
end
