return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      auto_attach = true,
      attach_to_untracked = true,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { desc = desc, buffer = bufnr })
        end

        map('n', '<leader>gs', gs.stage_buffer, '[G]it [S]tage current buffer')
        map('n', '<leader>gp', gs.preview_hunk, '[G]it [P]review hunk')
        map('n', '<leader>gb', function()
          gs.blame_line { full = true, ignore_whitespace = true }
        end, '[G]it [B]lame current line')
        map('n', '<leader>gt', gs.toggle_current_line_blame, '[G]it [T]oggle line blame')
      end,
    },
  },
}
