local set = vim.keymap.set

-- remove search highlight --
set("n", "<Esc>", ":nohlsearch<CR>")

-- move lines --
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '>-2<CR>gv=gv")

-- file navigation --
set("n", "-", ":Oil<CR>", { noremap = true, silent = true, desc = "Open Oil" })

-- terminal --
set("n", "<leader>t", ":below term<CR>i", { noremap = true, silent = true, desc = "Open Terminal Split" })
set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal and goto normal mode" })

-- Exec
set("n", "<leader>x", ":.lua<CR>", { desc = "Execute the current line" })
set("n", "<leader><leader>x", ":source %<CR>", { desc = "Execute the current file" })

-- LSP
set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })
set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Go to definition" })

-- Window Controls
set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
