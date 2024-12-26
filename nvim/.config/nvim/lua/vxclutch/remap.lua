-- remove search highlight --
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- move lines --
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- file navigation --
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { noremap = true, silent = true, desc = "Open Oil" })

-- compile --
vim.keymap.set("n", "<leader>m", ":make<CR>", { noremap = true, silent = false, desc = "Make" })

-- terminal --
vim.keymap.set("n", "<leader>t", ":below term<CR>i", { noremap = true, silent = true, desc = "Open Terminal Split" })
vim.keymap.set(
	"t",
	"<Esc><Esc>",
	"<C-\\><C-m>",
	{ noremap = true, silent = true, desc = "Go from Terminal mode to Normal mode" }
)

-- Exec
vim.keymap.set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Go to definition" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Window Controls
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- DAP
vim.keymap.set(
	"n",
	"<leader>b",
	":DapToggleBreakpoint<CR>",
	{ noremap = true, silent = true, desc = "Toggle Breakpoint" }
)
vim.keymap.set(
	"n",
	"<leader>db",
	":DapContinue<CR>",
	{ noremap = true, silent = true, desc = "Start or Contine the Debugger" }
)

-- Theme
vim.keymap.set(
	"n",
	"<leader><C-t>",
	":Themery<CR>",
	{ noremap = true, silent = false, desc = "Change the current theme" }
)
