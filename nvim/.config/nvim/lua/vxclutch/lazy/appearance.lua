return {
  "nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
    dependencies = {
      "norcalli/nvim-colorizer.lua",
			"zaldih/themery.nvim",
			"FrenzyExists/aquarium-vim",
			"vague2k/vague.nvim",
			"catppuccin/nvim",
    },
		config = function()
			require("lualine").setup({
				options = {
					theme = "ayu_mirage",
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
  			themes = {"aquarium", "vague", "catppuccin-mocha"},
  			livePreview = true,
			})
		end,
}
