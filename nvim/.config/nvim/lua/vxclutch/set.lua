local opt = vim.opt

-- command mode --
opt.inccommand = "split"
opt.smartcase = true
opt.ignorecase = true

-- line numbers --
opt.number = true
opt.relativenumber = true

-- splits --
opt.splitbelow = true
opt.splitright = true

-- tabs --
opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true

-- cursor --
opt.cursorline = true
opt.guicursor = ""
opt.scrolloff = 8

-- format --
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')
opt.signcolumn = "yes"
opt.termguicolors = true
opt.colorcolumn = "80"
