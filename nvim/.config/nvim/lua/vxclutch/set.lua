vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
vim.opt.termguicolors = true
vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.colorcolumn = "127"

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

vim.api.nvim_set_hl(0, 'TabLine', { fg = 'NONE', bg = 'NONE', underline = false })
vim.api.nvim_set_hl(0, 'TabLineSel', { fg = 'NONE', bg = 'NONE', underline = false })
vim.api.nvim_set_hl(0, 'TabLineFill', { fg = 'NONE', bg = 'NONE' })
vim.cmd [[
    highlight TabLine guibg=NONE guifg=NONE gui=NONE
    highlight TabLineSel guibg=NONE guifg=NONE gui=NONE
    highlight TabLineFill guibg=NONE guifg=NONE gui=NONE
]]

