local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Fix indentation behavior
keymap.set('n', '<', '<<<ESC>', opts)
keymap.set('n', '>', '>><ESC>', opts)
keymap.set('v', '<', '<gv', opts)
keymap.set('v', '>', '>gv', opts)

-- Fix handling wrapped lines
keymap.set({ 'n', 'v' }, 'j', 'gj', { silent = true })
keymap.set({ 'n', 'v' }, 'k', 'gk', { silent = true })

-- Handy helpers
keymap.set('v', 'J', ":m '>+1<cr>gv=gv", { silent = true })
keymap.set('v', 'K', ":m '<-2<cr>gv=gv", { silent = true })
keymap.set('n', 'x', '"_x')

-- Copy to system clipboard, Mapped to CMD-C
keymap.set('v', '<C-c>', '"*y')

-- Ensure there are no wrong spaces in files
vim.api.nvim_set_keymap('i', ' ', '<Space>', { noremap = true })

-- CMD+s = Format and save
keymap.set({ 'n', 'v' }, '<C-s>', function()
  if vim.fn.exists ':Format' == 2 then
    vim.cmd 'Format'
  end
  require('conform').format { async = false, lsp_fallback = true }
  vim.cmd 'w!'
end)

-- Open file explorer
keymap.set('n', '<C-e>', '<cmd>Oil<cr>', { desc = 'Filetree' })

-- Select All
keymap.set({ 'n', 'v' }, '<C-g>', 'ggVG', { noremap = true, silent = true })

-- Remove Search hl on ESC
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic
keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show [E]rror messages' })

-- Obsidian
keymap.set('n', '<C-o>d', '<cmd>ObsidianToday<cr>', { desc = '[O]bsidian [D]aily' })
keymap.set('n', '<C-o>n', '<cmd>ObsidianNew<cr>', { desc = '[O]bsidian [N]ew note' })
keymap.set('n', '<C-o>r', '<cmd>ObsidianRename<cr>', { desc = '[O]bsidian [R]ename Current Note' })

-- Splits
keymap.set('n', '<C-w>c', '<cmd>split<cr>', { desc = 'Split Horizontal' })
keymap.set('n', '<C-w>e', '<C-w>=', { desc = 'Split [E]qual Width' })
keymap.set('n', '<C-w>w', '<cmd>close<cr>', { desc = 'Close Split' })

-- Tabs
keymap.set('n', '<C-w>H', '<cmd>BufferPrevious<cr>', { desc = 'Tab Right' })
keymap.set('n', '<C-w>L', '<cmd>BufferNext<cr>', { desc = 'Tab Left' })
keymap.set('n', '<C-w>W', '<cmd>BufferClose!<cr>', { desc = 'Close Tab' })
