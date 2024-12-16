return {
  "nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
    dependencies = {
      "norcalli/nvim-colorizer.lua",
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
		end,
}
