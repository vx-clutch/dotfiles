vim.g.mapleader = " "

-- https://github.com/vx-clutch/ftl
vim.filetype.add {
  extension = {
    ftl = "ftl",
  },
}

require "vxclutch.set"
require "vxclutch.lazy_init"
require "vxclutch.remap"
