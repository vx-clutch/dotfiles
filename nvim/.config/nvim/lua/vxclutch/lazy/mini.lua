return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.ai").setup()
    require("mini.surround").setup()
    require("mini.pairs").setup()
    require("mini.pick").setup {
      window = {
        config = {
          anchor = "NW",
          row = 0,
          col = 0,
          width = 30,
        },
        style = 'minimal',
      border = 'rounded',
      },
      options = {
        use_cache = true,
      },
    }
  end,
}
