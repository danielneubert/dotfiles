vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 3000
vim.opt.timeoutlen = 1000
vim.opt.list = true
vim.opt.listchars = { tab = '⇥ ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.g.disable_autoformat = true
vim.opt.foldenable = false

vim.opt.laststatus = 2

vim.opt.scrolloff = 5
vim.opt.cursorline = true
vim.opt.colorcolumn = '80'

-- Window Title
vim.opt.title = true
vim.opt.titlestring = "vim %{substitute(getcwd(), $HOME, '~', '')}"

-- Numbers
vim.opt.number = true

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
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.cache/nvim/undo'
vim.opt.undofile = true
vim.opt.backspace = 'indent,eol,start'

-- Window Management
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Color Setup
vim.opt.termguicolors = true

-- PHP word seperation to select [$this] not $[this]
vim.opt.iskeyword:append '$'

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  require('conform').format { async = true, lsp_format = 'fallback', range = range }
end, { range = true })
