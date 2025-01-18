vim.g.mapleader = " "

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Remove search highlight --
map("n", "<Esc>", ":nohlsearch<CR>")

-- Move lines --
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '>-2<CR>gv=gv")

-- Scrolling --
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- File navigation --
map("n", "<leader>pv", ":Oil<CR>")

-- Terminal --
map("t", "<C-k>", "<C-\\><C-n><C-w><C-k>")

-- Exec
map("n", "<leader>x", ":.lua<CR>")
map("n", "<leader><leader>x", ":source %<CR>")

-- LSP
map("n", "gd", vim.lsp.buf.definition)
map("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Go to definition" })

-- Window Controls
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
