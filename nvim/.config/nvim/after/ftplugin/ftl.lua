local fn = vim.fn

-- Function to add keyword highlighting
local function keywordsadd(keywords)
  local pattern = "\\<\\(" .. table.concat(keywords, "\\|") .. "\\)\\>"
  fn.matchadd("Keyword", pattern)
end

local function setup_highlight_groups()
  vim.api.nvim_set_hl(0, "ftl_Keyword", { link = "Keyword" })
  vim.api.nvim_set_hl(0, "ftl_String", { link = "String" })
  vim.api.nvim_set_hl(0, "ftl_Comment", { link = "Comment" })
  vim.api.nvim_set_hl(0, "ftl_Number", { link = "Number" })
end

setup_highlight_groups()

-- Add custom highlights
keywordsadd { "if", "else", "while", "for", "SYSCALL", "exit" }
fn.matchadd("ftl_Keyword", "\\<\\(if\\|else\\|while\\|for\\|SYSCALL\\|exit\\)\\>")
fn.matchadd("ftl_String", [["\zs[^"]*\ze"]])
fn.matchadd("ftl_Comment", [[;;.*]])
fn.matchadd("ftl_Number", [[\v<\d+>]])
