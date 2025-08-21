vim.o.number = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.o.wrap = false
vim.o.winborder = "rounded"
vim.opt.wildoptions = {}

vim.g.mapleader = " "
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>o", ":Pick files<CR>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>en", ":edit $HOME/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>z", ":edit $HOME/.zshrc<CR>")

vim.pack.add({
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/hrsh7th/nvim-cmp' },
	{ src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
	{ src = 'https://github.com/chomosuke/typst-preview.nvim' },
})

require "mini.pick".setup()
require "mason".setup()
require 'typst-preview'.setup {}

local cmp = require("cmp")
cmp.setup({
	preselect = cmp.PreselectMode.Item,
	completion = { completeopt = "menu,menuone,noinsert" },

	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-e>"] = cmp.mapping.abort(),
	}),

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
	}),

	performance = {
		max_view_entries = 5,
	},

	window = {
		completion = cmp.config.window.bordered {
			border = 'rounded', }
	}
})

vim.lsp.enable({ "lua_ls", "clangd", "tinymist" })

vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	signs = false,
})
