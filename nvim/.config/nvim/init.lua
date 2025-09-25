vim.cmd.colorscheme("desert")
vim.cmd("hi Normal guibg=#181818")
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

vim.keymap.set("n", "<leader>en", ":edit $XDG_CONFIG_HOME/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>ez", ":edit $ZSHRC<CR>")
vim.keymap.set("n", "<leader>ed", ":edit $DO<CR>")

vim.keymap.set("n", "<leader><leader>", function()
	local alt = vim.fn.expand("%:r") .. (vim.bo.filetype == "c" and ".h" or ".c")
	vim.cmd("edit " .. alt)
end)

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*",
	callback = function()
		local ext = vim.fn.expand("%:e")
		local firstline = vim.fn.getline(1)
		if ext == "" and not firstline:match("^#!") then
			vim.bo.filetype = "noext"
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.h",
	callback = function()
		vim.bo.filetype = "c"
	end,
})

vim.pack.add {
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
}

require("mini.pick").setup()
require("mason").setup()

require 'lspconfig'.clangd.setup {
	filetypes = { "c", "cpp" },
	init_options = {
		compilationDatabasePath = "build",
	},
	on_attach = function(client, bufnr)
		if vim.bo.filetype == "c" and vim.fn.expand("%:e") == "h" then
			client.config.flags = client.config.flags or {}
			client.config.flags.allow_incremental_sync = true
		end
	end,
}


vim.lsp.enable { "lua_ls", "clangd", "beautysh" }
vim.diagnostic.config { virtual_text = true, underline = true, signs = false }
