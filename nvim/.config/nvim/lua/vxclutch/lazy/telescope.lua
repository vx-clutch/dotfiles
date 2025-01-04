return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.5",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  config = function()
    require("telescope").setup {}

    local builtin = require "telescope.builtin"
    vim.keymap.set("n", "<leader><leader>", builtin.find_files, {})
    vim.keymap.set("n", "<C-p>", builtin.git_files, {})
    vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
    vim.keymap.set("n", "<leader>sg", function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      }
    end, { desc = "[S]earch [/] in Open Files" })
    vim.keymap.set("n", "<leader>sn", function()
      builtin.find_files { cwd = vim.fn.stdpath "config" }
    end, { desc = "[S]earch [N]eovim files" })
  end,
}
