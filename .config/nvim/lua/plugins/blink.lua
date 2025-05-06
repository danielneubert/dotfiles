return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    opts = {
      keymap = {
        preset = 'enter',
        ['<Esc>'] = { 'fallback' },
        ['<Tab>'] = { 'select_and_accept', 'fallback' },
        ['<M-k>'] = { 'select_prev', 'fallback' },
        ['<M-j>'] = { 'select_next', 'fallback' },
        ['<C-Tab>'] = { 'snippet_forward', 'fallback' },
        ['<C-S-Tab>'] = { 'snippet_backward', 'fallback' },
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = { documentation = { auto_show = false } },

      signature = { enabled = true },

      sources = {
        default = { 'lsp', 'path', 'snippets' },
        -- default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
  },
}
