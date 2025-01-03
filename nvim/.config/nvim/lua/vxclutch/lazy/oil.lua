return {
  "stevearc/oil.nvim",
  opts = {},
  config = function()
    require("oil").setup {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == ".." or name == ".git"
        end,
      },
    }

    -- File nav split
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
