vim.g.mapleader = " "

-- https://github.com/vx-clutch/ftl
vim.filetype.add {
  extension = {
    ftl = "ftl",
  },
}

require "vxclutch.set"
require "vxclutch.lazy_init"
vim.api.nvim_set_hl(0, "Function", { bold = false }) -- Must be called last.
require "vxclutch.remap"
