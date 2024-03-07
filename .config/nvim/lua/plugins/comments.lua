return {
  {
    'numToStr/Comment.nvim',
    opts = {},
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      keywords = {
        DEV = {
          -- DEV: Important keywords
          color = 'error',
          alt = { 'DEBUG', 'FIX', 'BUG', 'ISSUE' },
        },
        WARN = {
          -- WARN: Warning keywords
          color = 'warning',
          alt = { 'WARNING', 'XXX' },
        },
        NOTE = {
          -- NOTE: Info keywords
          color = 'hint',
          alt = { 'INFO' },
        },
        TEST = {
          -- TEST: Unwanted keywords
          color = 'default',
          alt = { 'OPTIMIZE', 'TESTING', 'TEST', 'PASSED', 'FAILED', 'FIXME', 'BUG', 'FIXIT', 'ISSUE', 'HACK', 'PERF', 'PERFORMANCE' },
        },
      },
      signs = false,
      colors = {
        dev = { 'DiagnosticError', 'ErrorMsg' },
        warn = { 'DiagnosticWarn', 'WarningMsg' },
        note = { 'DiagnosticHint' },
        default = { 'Normal' },
      },
    },
  },
}
