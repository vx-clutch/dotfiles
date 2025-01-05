return {
  "stevearc/oil.nvim",
  opts = {},
  config = function()
    require("oil").setup {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      use_default_keymaps = true,
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["-"] = { "actions.parent", mode = "n" },
        ["g."] = { "actions.toggle_hidden", mode = "n" },
      },
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == ".." or name == ".git"
        end,
      },
    }

    -- vim.api.nvim_create_autocmd("FileType", {
    --   pattern = "oil",
    --   callback = function()
    --     vim.api.nvim_buf_set_keymap(0, "n", function()
    --       local cursor_line = vim.api.nvim_get_current_line()
    --       if string.sub(cursor_line, -1) == "/" then
    --         vim.cmd("silent! cd " .. cursor_line)
    --       end
    --     end, { noremap = true, silent = true })
    --   end,
    -- })

    -- File navigation split with Oil
    vim.api.nvim_create_user_command("Pick", function()
      local origin_buf = vim.fn.bufnr()
      vim.cmd "new | Oil"

      local oil_opened = false
      vim.api.nvim_create_autocmd("BufReadPost", {
        pattern = "*",
        callback = function()
          if vim.bo.filetype == "oil" then
            oil_opened = true
          end
          if vim.bo.filetype ~= "oil" and oil_opened then
            vim.api.nvim_buf_delete(origin_buf, { force = true })
          end
        end,
      })
    end, {})
  end,
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
