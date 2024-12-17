return {
	"nvim-lualine/lualine.nvim",
	requires = { "kyazdani42/nvim-web-devicons" },
	dependencies = {
		"norcalli/nvim-colorizer.lua",
		"zaldih/themery.nvim",
		"FrenzyExists/aquarium-vim",
		"vague2k/vague.nvim",
		"catppuccin/nvim",
		"morhetz/gruvbox",
		"shaunsingh/nord.nvim",
		"rose-pine/neovim",
		"folke/tokyonight.nvim",
	},
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				component_separators = "",
				section_separators = "",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {
					function()
						return "[" .. vim.bo.filetype .. "]"
					end,
				},
			},
		})
		require("colorizer").setup({
			"*",
			css = { rgb_fn = true },
		})
		require("themery").setup({
			themes = {
				"aquarium",
				"vague",
				"catppuccin-mocha",
				"gruvbox",
				"catppuccin-frappe",
				"catppuccin-macchiato",
				"nord",
				"rose-pine",
				"tokyonight",
			},
			livePreview = true,
		})
	end,
}
