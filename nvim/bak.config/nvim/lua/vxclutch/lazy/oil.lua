return {
	"stevearc/oil.nvim",
	opts = {},
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			use_default_keymaps = true,
			keymaps = {
				["g?"] = { "actions.show_help", mode = "n" },
				["<CR>"] = { "actions.select" },
				["<C-s>"] = false,
				["<C-h>"] = false,
				["<C-t>"] = false,
				["<C-p>"] = false,
				["<C-c>"] = false,
				["<C-r>"] = { "actions.refresh" },
				["-"] = { "actions.parent", mode = "n" },
				["_"] = { "actions.open_cwd", mode = "n" },
				["<leader>d"] = { "actions.cd", mode = "n" },
				["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
				["gs"] = false,
				["gx"] = { "actions.open_external" },
				["g."] = { "actions.toggle_hidden", mode = "n" },
			},
			view_options = {
				show_hidden = true,
				natural_order = true,
				is_always_hidden = function(name, _)
					return name == ".." or name == ".git"
				end,
			},
		})
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
