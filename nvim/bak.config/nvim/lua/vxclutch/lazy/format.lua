return {
  "stevearc/conform.nvim",
  dependencies = {
    "tpope/vim-sleuth",
  },
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format { async = true, lsp_fallback = true }
      end,
      mode = "",
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
    },
    hooks = {
      pre_format = function(lines, _)
        -- Strip comments
        local no_comments = {}
        for _, line in ipairs(lines) do
          if not line:match "%s*//" and not line:match "%s*/%*.*%*/" then
            table.insert(no_comments, line)
          end
        end
        return no_comments
      end,
    },
  },
}
