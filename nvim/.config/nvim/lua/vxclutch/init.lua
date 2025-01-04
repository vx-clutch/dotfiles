vim.g.mapleader = " "

-- https://github.com/vx-clutch/ftl
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = "*.ftl",
    callback = function()
        vim.bo.filetype = "c"
    end,
})


require "vxclutch.set"
require "vxclutch.lazy_init"
require "vxclutch.remap"
