local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set('n', '<', '<<<ESC>', opts)
keymap.set('n', '>', '>><ESC>', opts)

keymap.set('v', '<', '<gv', opts)
keymap.set('v', '>', '>gv', opts)

vim.keymap.set({ 'n', 'v' }, 'j', 'gj', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'k', 'gk', { silent = true })

vim.keymap.set('v', 'J', ":m '>+1<cr>gv=gv", { silent = true })
vim.keymap.set('v', 'K', ":m '<-2<cr>gv=gv", { silent = true })
vim.keymap.set('n', 'x', '"_x')

vim.keymap.set('v', '<C-c>', '"*y')
vim.api.nvim_set_keymap('i', ' ', '<Space>', { noremap = true })

vim.keymap.set({ 'n', 'v' }, '<C-s>', function()
  require('conform').format { async = false, lsp_fallback = true }
  vim.cmd 'w!'
end)

vim.keymap.set('n', '<leader>fe', '<cmd>NvimTreeToggle<cr>', { desc = '[F]ind in [E]xplorer' }) -- open the nvim tree (mapped in iTerm to CMD-E)
vim.keymap.set('n', '<C-e>', '<cmd>NvimTreeToggle<cr>') -- open the nvim tree (mapped in iTerm to CMD-E)

vim.keymap.set({ 'n', 'v' }, '<C-g>', 'ggVG', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>sv', '<C-w>v', { desc = '[S]plit [V]ertical (right)' }) -- split vertical
vim.keymap.set('n', '<leader>sc', '<C-w>s', { desc = '[S]plit Horizontal (below)' }) -- split vertical
vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = '[S]plit [E]qual Width' }) -- split vertical
vim.keymap.set('n', '<leader>sw', '<cmd>close<cr>', { desc = 'Close [S]plit' }) -- close active split
vim.keymap.set('n', '<leader>sh', '<C-w>h', { desc = 'Go left [S]plit' }) -- move cursor next split
vim.keymap.set('n', '<leader>sj', '<C-w>j', { desc = 'Go lower [S]plit' }) -- move cursor next split
vim.keymap.set('n', '<leader>sk', '<C-w>k', { desc = 'Go upper [S]plit' }) -- move cursor prev split
vim.keymap.set('n', '<leader>sl', '<C-w>l', { desc = 'Go right [S]plit' }) -- move cursor prev split
vim.keymap.set('n', '<M-w>', '<cmd>close<cr>') -- close active split
vim.keymap.set('n', '<M-h>', '<C-w>h') -- move cursor next split
vim.keymap.set('n', '<M-l>', '<C-w>l') -- move cursor prev split
vim.keymap.set('n', '<M-j>', '<C-w>j') -- move cursor next split
vim.keymap.set('n', '<M-k>', '<C-w>k') -- move cursor prev split

vim.keymap.set('n', '<leader>th', '<cmd>bpre<cr>')
vim.keymap.set('n', '<leader>tl', '<cmd>bnext<cr>')
vim.keymap.set('n', '<leader>tw', '<cmd>bd!<cr>')
vim.keymap.set('n', '<C-h>', '<cmd>bpre<cr>')
vim.keymap.set('n', '<C-l>', '<cmd>bnext<cr>')
vim.keymap.set('n', '<C-w>', '<cmd>bd!<cr>')

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>en', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', '<leader>ep', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
