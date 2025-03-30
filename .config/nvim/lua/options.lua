vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true

vim.opt.colorcolumn = "81,121"

-- Don't wrap long lines
vim.opt.wrap = false

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.mouse = "a"

-- tabs & indent
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true

vim.o.cursorline = true

-- Enable break indent
vim.opt.breakindent = true

-- Save un.opt.history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C.opt. capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- .opt.E: You should make sure your terminal supports this
vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.backspace = "indent,eol,start"

vim.opt.list = true
vim.opt.listchars = "eol:↵,trail:~,tab:> ,nbsp:o"
vim.opt.scrolloff = 8

vim.opt.clipboard:append("unnamedplus")

vim.opt.swapfile = false

-- Highlight trailing whitespace
vim.cmd("highlight SpecialKey ctermbg=blue guibg=blue")
vim.cmd("highlight ExtraWhitespace ctermbg=red guibg=red")
vim.cmd("match ExtraWhitespace /\\s\\+$/")
