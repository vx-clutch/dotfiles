return {
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "nvim-telescope/telescope.nvim",

    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    config = function()
      local data = assert(vim.fn.stdpath "data") --[[@as string]]

      require("telescope").setup {
        extensions = {
          wrap_results = true,

          fzf = {},
          history = {
            path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
            limit = 100,
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
          },
        },
      }

      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "smart_history")
      pcall(require("telescope").load_extension, "ui-select")

      local builtin = require "telescope.builtin"

      vim.keymap.set("n", "<space>pf", builtin.find_files)
      vim.keymap.set("n", "<C-p>", builtin.git_files)
      vim.keymap.set("n", "<space>fh", builtin.help_tags)
      vim.keymap.set("n", "<space>fg", builtin.git_files)
      vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find)

      vim.keymap.set("n", "<leader>ps", function()
        builtin.grep_string { search = vim.fn.input "Grep > " }
      end)

      vim.keymap.set("n", "<space>en", function()
        builtin.find_files { cwd = vim.fn.stdpath "config" }
      end)
    end,
  },
}
