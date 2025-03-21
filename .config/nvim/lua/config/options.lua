vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 100
vim.opt.timeoutlen = 1000
vim.opt.list = true
vim.opt.listchars = { tab = '⇥ ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.g.disable_autoformat = true

-- Cursor
vim.opt.scrolloff = 8
-- vim.opt.guicursor = ''
vim.opt.cursorline = true
vim.opt.colorcolumn = '80'

-- Window Title
vim.opt.title = true
vim.opt.titlestring = "vim %{substitute(getcwd(), $HOME, '~', '')}"

-- Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.wrap = true

-- File Encoding
vim.opt.encoding = 'utf-8'
vim.scriptencoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true

-- Vim Is Awesome
vim.opt.swapfile = false
vim.opt.backspace = 'indent,eol,start'

-- Window Management
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Color Setup
vim.opt.termguicolors = true

-- Color Setup
vim.opt.foldenable = false

-- PHP word seperation to select [$this] not $[this]
vim.opt.iskeyword:append '$'

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        vim.cmd [[
      augroup MarkdownSyntaxMatch
        autocmd!
        autocmd FileType markdown syntax match @conceal /```/ conceal cchar=┉
      augroup END
    ]]
    end,
})
