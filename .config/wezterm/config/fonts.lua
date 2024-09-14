local wezterm = require 'wezterm'

function SetupFonts(config)
  config.freetype_load_target = 'Normal'
  config.font_size = 17
  config.line_height = 1.1
  config.font_rules = {
    {
      italic = false,
      font = wezterm.font {
        family = 'ComicCodeLigatures',
        stretch = 'Normal',
        weight = 500,
        italic = false,
      },
    },
    {
      italic = true,
      font = wezterm.font {
        family = 'ComicCodeLigatures',
        stretch = 'Normal',
        weight = 500,
        italic = true,
      },
    },
  }
end
