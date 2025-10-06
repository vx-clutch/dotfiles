vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.g.mapleader = " "
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
for _, k in ipairs({ "h", "j", "k", "l" }) do
	vim.keymap.set({ "n", "i", "v" }, "<C-" .. k .. ">", "<C-w><C-" .. k .. ">")
end

vim.keymap.set("n", "<leader>en", ":edit $MYVIMRC<CR>")
vim.keymap.set("n", "<leader>ez", ":edit ~/.zshrc<CR>")

vim.pack.add {
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/vague2k/vague.nvim" },
}

require("mason").setup()
require("telescope").setup()

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files)
vim.keymap.set('n', '<leader>sg', builtin.live_grep)
vim.keymap.set('n', '<leader>sb', builtin.buffers)
vim.keymap.set('n', '<leader>sh', builtin.help_tags)
vim.keymap.set('n', '<leader>sm', builtin.man_pages)

vim.lsp.config.clangd = {
	filetypes = { "c", "cpp", "h", "hpp" },
	init_options = {
		compilationDatabasePath = ".",
	},
	on_attach = function(client, bufnr)
		if vim.bo.filetype == "c" and vim.fn.expand("%:e") == "h" then
			client.config.flags = client.config.flags or {}
			client.config.flags.allow_incremental_sync = true
		end
	end,
}


vim.lsp.enable { "clangd" }
vim.diagnostic.config { virtual_text = true, underline = true, signs = false }

vim.cmd.colorscheme("vague")
