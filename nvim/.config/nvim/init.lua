vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.winborder = "rounded"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.wildoptions = {}

vim.g.mapleader = " "
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>r>", ":make<CR>")
vim.keymap.set("n", "<leader>o", ":Pick files<CR>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
for _, k in ipairs({ "h", "j", "k", "l" }) do
	vim.keymap.set({ "n", "i", "v" }, "<C-" .. k .. ">", "<C-w><C-" .. k .. ">")
end
vim.keymap.set("n", "<leader>en", ":edit $HOME/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>ez", ":edit $HOME/.zshrc<CR>")

vim.keymap.set("n", "<leader><leader>", function()
	local alt = vim.fn.expand("%:r") .. (vim.bo.filetype == "c" and ".h" or ".c")
	vim.cmd("edit " .. alt)
end)

vim.pack.add {
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/mason-org/mason.nvim" },
}

require("mini.pick").setup()
require("mason").setup()

vim.lsp.enable { "lua_ls", "clangd" }
vim.diagnostic.config { virtual_text = true, underline = true, signs = false }
