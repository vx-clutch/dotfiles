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

-- opt.shiftwidth = 2 --
opt.shiftwidth = 2

-- cursor --
opt.cursorline = true
opt.guicursor = ""
opt.scrolloff = 8

-- format --
opt.formatoptions:remove "o"
opt.signcolumn = "yes"
opt.termguicolors = true
