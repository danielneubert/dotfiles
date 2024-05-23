return {
  {
    'zbirenbaum/copilot.lua',
    priority = 1000,
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 50,
        keymap = {
          accept = '<M-Tab>',
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ['.'] = false,
        ['.env'] = false,
      },
    },
  },
}
