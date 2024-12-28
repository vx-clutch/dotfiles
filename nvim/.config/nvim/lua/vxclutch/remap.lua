local set = vim.keymap.set

-- remove search highlight --
set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- move lines --
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '>-2<CR>gv=gv")

-- file navigation --
set("n", "-", "<cmd>Oil<CR>", { noremap = true, silent = true, desc = "Open Oil" })

-- compile --
set("n", "<leader>m", ":make<CR>", { noremap = true, silent = false, desc = "Make" })
set("n", "<leader>cc", ":Compile<CR>", { noremap = true, silent = false, desc = "Compile" })
set("n", "<leader>rc", ":Recompile<CR>", { noremap = true, silent = false, desc = "Recompile" })

-- terminal --
set("n", "<leader>t", ":below term<CR>i", { noremap = true, silent = true, desc = "Open Terminal Split" })

-- Exec
set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

-- LSP
set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })
set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Go to definition" })

-- Window Controls
set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Theme
set(
	"n",
	"<leader><C-t>",
	":Themery<CR>",
	{ noremap = true, silent = false, desc = "Change the current theme" }
)
