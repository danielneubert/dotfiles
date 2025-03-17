local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("i", "<Esc>", function()
    -- hide the completion menu
    require('blink.cmp').hide()

    -- stop the completion
    vim.cmd("stopinsert")
end, opts)

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

-- Save, Mapped to CMD-s
keymap.set({ 'n', 'v' }, '<C-s>', function()
    if vim.fn.exists(':Format') == 2 then
        vim.cmd 'Format'
    end
    require('conform').format { async = false, lsp_fallback = true }
    vim.cmd 'w!'
end)

-- [gd] will be overwritten by other LSPs if not in Obsidian folder
keymap.set('n', 'gd', '<cmd>ObsidianFollowLink<cr>', { desc = 'Obsidian [G]o[T]o Link' })

-- File handling
-- keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = '[F]ind with [T]odos' })
-- keymap.set('n', '<C-e>', '<cmd>NvimTreeToggle<cr>', { desc = 'Filetree' }) -- Mapped to CMD-e
keymap.set('n', '<C-e>', '<cmd>Oil<cr>', { desc = 'Filetree' }) -- Mapped to CMD-e

-- Obsidian
keymap.set('n', '<C-o>d', '<cmd>ObsidianToday<cr>', { desc = '[O]bsidian [D]aily' })
keymap.set('n', '<C-o>n', '<cmd>ObsidianNew<cr>', { desc = '[O]bsidian [N]ew note' })
keymap.set('n', '<C-o>r', '<cmd>ObsidianRename<cr>', { desc = '[O]bsidian [R]ename Current Note' })

-- Select All
keymap.set({ 'n', 'v' }, '<C-g>', 'ggVG', { noremap = true, silent = true })

-- Remove Search hl on ESC
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic
keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show [E]rror messages' })
keymap.set('n', '<leader>ep', vim.diagnostic.goto_prev, { desc = 'Go to [P]revious [E]rror message' })
keymap.set('n', '<leader>en', vim.diagnostic.goto_next, { desc = 'Go to [N]ext [E]rror message' })

-- Splits
keymap.set('n', '<C-w>c', '<cmd>split<cr>', { desc = 'Split Horizontal' })
keymap.set('n', '<C-w>e', '<C-w>=', { desc = 'Split [E]qual Width' })
keymap.set('n', '<C-w>w', '<cmd>close<cr>', { desc = 'Close Split' })

-- Tabs
keymap.set('n', '<C-w>H', '<cmd>BufferPrevious<cr>', { desc = 'Tab Right' })
keymap.set('n', '<C-w>L', '<cmd>BufferNext<cr>', { desc = 'Tab Left' })
keymap.set('n', '<C-w>W', '<cmd>BufferClose!<cr>', { desc = 'Close Tab' })
