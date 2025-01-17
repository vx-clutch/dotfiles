vim.g.mapleader = " "

require "vxclutch.set"
require "vxclutch.lazy_init"
require "vxclutch.remap"
vim.api.nvim_set_hl(0, "Function", { bold = false }) -- Must be called last.
require("nvim-colorizer").setup()
