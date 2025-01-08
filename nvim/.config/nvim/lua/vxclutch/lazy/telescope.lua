return {
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

    vim.keymap.set("n", "<space>fd", builtin.find_files)
    vim.keymap.set("n", "<C-p>", builtin.git_files)
    vim.keymap.set("n", "<space>fh", builtin.help_tags)
    vim.keymap.set("n", "<space>fg", builtin.live_grep)
    vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find)

    vim.keymap.set("n", "<space>fw", builtin.grep_string)

    vim.keymap.set("n", "<space>fn", function()
      builtin.find_files { cwd = vim.fn.stdpath "config" }
    end)
  end,
}
