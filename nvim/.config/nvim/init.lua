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
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
}

require("mini.pick").setup()
require("mason").setup()

local cmp = require("cmp")
cmp.setup {
	preselect = cmp.PreselectMode.Item,
	completion = { completeopt = "menu,menuone,noinsert" },
	mapping = cmp.mapping.preset.insert {
		["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
		["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
		["<C-y>"] = cmp.mapping.confirm { select = true },
		["<C-Space>"] = cmp.mapping.complete(),
	},
	sources = { { name = "nvim_lsp" } },
	performance = { max_view_entries = 5 },
	window = {
		completion = cmp.config.window.bordered { border = "rounded" },
		documentation = cmp.config.window.bordered { border = "rounded" },
	},
}

local lc = require("lspconfig")
lc.jdtls.setup {
	cmd = { "jdtls", "-configuration", vim.fn.stdpath("cache") .. "/jdtls/config", "-data", vim.fn.stdpath("cache") .. "/jdtls/workspace" },
	filetypes = { "java" },
	root_dir = lc.util.root_pattern(".git", "."),
}

vim.lsp.enable { "lua_ls", "clangd", "jdtls" }
vim.diagnostic.config { virtual_text = true, underline = true, signs = false }
