return {
  -- this is a sort of related
  {
    "stevearc/dressing.nvim"
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      {
        "<leader>t",
        function()
          Snacks.terminal.toggle()
        end,
      },
      {
        "<leader>lg",
        function()
          Snacks.lazygit()
        end,
      },
    },
  },
}
