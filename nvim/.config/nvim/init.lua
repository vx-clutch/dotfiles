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
vim.keymap.set("n", "<leader>en", ":edit $MYVIMRC<CR>")
vim.keymap.set("n", "<leader>ez", ":edit ~/.zshrc<CR>")

vim.pack.add {
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/blazkowolf/gruber-darker.nvim" },
}

local telescope = require("telescope")
telescope.setup({
	defaults = {
		preview = { treesitter = false },
		color_devicons = true,
		sorting_strategy = "ascending",
		borderchars = {
			"─", -- top
			"│", -- right
			"─", -- bottom
			"│", -- left
			"┌", -- top-left
			"┐", -- top-right
			"┘", -- bottom-right
			"└", -- bottom-left
		},
		path_displays = { "smart" },
		layout_config = {
			height = 100,
			width = 400,
			prompt_position = "top",
			preview_cutoff = 40,
		}
	}
})
telescope.load_extension("ui-select")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files)
vim.keymap.set('n', '<leader>sg', builtin.live_grep)
vim.keymap.set('n', '<leader>sb', builtin.buffers)
vim.keymap.set('n', '<leader>sh', builtin.help_tags)
vim.keymap.set('n', '<leader>sm', builtin.man_pages)

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "h", "hpp" },
    callback = function()
        vim.lsp.start {
            name = "clangd",
            cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed", "--header-insertion=iwyu" },
            root_dir = vim.fs.dirname(vim.fs.find({ ".git", "Makefile", "makefile", "README" }, { upward = true })[1]),
        }
    end,
})

vim.diagnostic.config { virtual_text = true, underline = true, signs = false }

vim.cmd.colorscheme("gruber-darker")
