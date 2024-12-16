return {
	"ej-shafran/compile-mode.nvim",
	branch = "nightly",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		---@type CompileModeOpts
		vim.g.compile_mode = {}
	end,
}
