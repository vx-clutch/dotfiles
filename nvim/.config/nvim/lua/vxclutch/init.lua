require("vxclutch.set")
require("vxclutch.remap")
require("vxclutch.lazy_init")


local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local VxclutchGroup = augroup('Vxclutch', {})

autocmd('BufEnter', {
    group = VxclutchGroup,
    callback = function()
        if vim.bo.filetype == "zig" then
            vim.cmd.colorscheme("tokyonight-night")
        else
            vim.cmd.colorscheme("rose-pine-moon")
        end
    end
})
