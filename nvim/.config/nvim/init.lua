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

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")
vim.keymap.set("n", "<leader>r", "") -- TODO(vx-clutch): Compile then move to last opened buffer
vim.keymap.set("n", "<leader>en", ":edit $MYVIMRC<CR>")
vim.keymap.set("n", "<leader>ez", ":edit ~/.zshrc<CR>")

vim.pack.add {
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/ej-shafran/compile-mode.nvim" },
	{ src = "https://github.com/blazkowolf/gruber-darker.nvim" },
}

require("mason").setup()
require("telescope").setup()

vim.g.compile_mode = {}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files)
vim.keymap.set('n', '<leader>sg', builtin.live_grep)
vim.keymap.set('n', '<leader>sb', builtin.buffers)
vim.keymap.set('n', '<leader>sh', builtin.help_tags)
vim.keymap.set('n', '<leader>sm', builtin.man_pages)

vim.lsp.config.clangd = {
    	cmd = { 'clangd', '--background-index', '--clang-tidy', '--completion-style=detailed', '--header-insertion=iwyu' },
	filetypes = { 'c', 'h', 'cc', 'cpp', 'hpp' },
	root_dir = function (fname)
        	return vim.fs.dirname(vim.fs.find({ '.git', 'Makefile', 'CMakeLists.txt' }, { upward = true })[1])
    	end,
	single_file_support = true,
}

vim.lsp.enable { "clangd" }
vim.diagnostic.config { virtual_text = true, underline = true, signs = false }

vim.cmd.colorscheme("gruber-darker")
