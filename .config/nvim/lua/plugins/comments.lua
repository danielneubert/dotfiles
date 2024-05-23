return {
  {
    'numToStr/Comment.nvim',
    priority = 1000,
    opts = {},
  },

  {
    'folke/todo-comments.nvim',
    priority = 1000,
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      keywords = {
        DEV = {
          -- DEV Important keywords
          color = 'error',
          alt = { 'DEBUG', 'FIX', 'BUG', 'ISSUE' },
        },
        WARN = {
          -- WARN Warning keywords
          color = 'warning',
          alt = { 'WARNING', 'XXX' },
        },
        NOTE = {
          -- NOTE Info keywords
          color = 'hint',
          alt = { 'INFO', 'NOTE:' },
        },
        TEST = {
          -- TEST Unwanted keywords
          color = 'default',
          alt = { 'OPTIMIZE', 'TESTING', 'TEST', 'PASSED', 'FAILED', 'FIXME', 'BUG', 'FIXIT', 'ISSUE', 'HACK', 'PERF', 'PERFORMANCE' },
        },
        TODO = {
          -- TODO Unwanted keywords
          color = 'default',
          alt = { 'TODO:' },
        },
      },
      highlight = {
        pattern = [[.*<(KEYWORDS)\s]],
      },
      signs = false,
      colors = {
        dev = { 'DiagnosticError', 'ErrorMsg' },
        warn = { 'DiagnosticWarn', 'WarningMsg' },
        note = { 'DiagnosticHint' },
        default = { 'Normal' },
      },
      search = {
        command = 'rg',
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
        },
        pattern = [[\b(KEYWORDS)\b]],
      },
    },
  },
}
