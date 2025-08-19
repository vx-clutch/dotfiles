vim.cmd.colorscheme("vim")
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
vim.g.mapleader = " "

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>o", ":Pick files<CR>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>en", ":edit $HOME/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>z", ":edit $HOME/.zshrc<CR>")

vim.o.number = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.o.wrap = false
vim.opt.wildoptions = {}
vim.opt.path:append("**")

-- TODO(vx-clutch): fix the C behavior, // > /*
vim.api.nvim_create_user_command("Copyright", function()
    local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
    local repo_path = handle and handle:read("*l") or nil
    if handle then handle:close() end

    local repo = repo_path and repo_path:match("([^/]+)$") or "unknown"

    local header_lines = {
        "Copyright (C) vx_clutch",
        "",
        "This file is part of " .. repo,
        "",
        "This project and file is licensed under the BSD-3-Clause license.",
        "<https://opensource.org/license/bsd-3-clause>",
    }

    local cstr = vim.bo.commentstring

    local commented = {}

    if cstr ~= "" and cstr:find("%%s") then
        local function comment(line)
            if line == "" then
                return ""
            end
            local res = cstr:gsub("%%s", line)
            return res
        end

        for _, l in ipairs(header_lines) do
            table.insert(commented, comment(l))
        end
        table.insert(commented, "")
    else
        table.insert(commented, "/*")
        for _, l in ipairs(header_lines) do
            if l == "" then
                table.insert(commented, " *")
            else
                table.insert(commented, " * " .. l)
            end
        end
        table.insert(commented, " */")
        table.insert(commented, "")
    end

    vim.api.nvim_buf_set_lines(0, 0, 0, false, commented)
end, {})


local augroup = vim.api.nvim_create_augroup("vxclutch", {})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})


vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	callback = function()
		local dir = vim.fn.expand('<afile>:p:h')
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, 'p')
		end
	end,
})

local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

local terminal_state = {
	buf = nil,
	win = nil,
	is_open = false
}

local function FloatingTerminal()
	if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
		return
	end


	if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
		terminal_state.buf = vim.api.nvim_create_buf(false, true)

		vim.api.nvim_buf_set_option(terminal_state.buf, 'bufhidden', 'hide')
	end


	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
		relative = 'editor',
		width = width,
		height = height,
		row = row,
		col = col,
		style = 'minimal',
		border = 'rounded',
	})


	vim.api.nvim_win_set_option(terminal_state.win, 'winblend', 0)


	vim.api.nvim_win_set_option(terminal_state.win, 'winhighlight',
		'Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder')


	vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none", })


	local has_terminal = false
	local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
	for _, line in ipairs(lines) do
		if line ~= "" then
			has_terminal = true
			break
		end
	end

	if not has_terminal then
		vim.fn.termopen(os.getenv("SHELL"))
	end

	terminal_state.is_open = true
	vim.cmd("startinsert")


	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = terminal_state.buf,
		callback = function()
			if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
				vim.api.nvim_win_close(terminal_state.win, false)
				terminal_state.is_open = false
			end
		end,
		once = true
	})
end


local function CloseFloatingTerminal()
	if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
	end
end
vim.keymap.set("n", "<leader>t", FloatingTerminal, { noremap = true, silent = true })
vim.keymap.set("t", "<Esc>", function()
	if terminal_state.is_open then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
	end
end, { noremap = true, silent = true })

vim.pack.add({
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/mason-org/mason.nvim" },
})

require "mini.pick".setup()
require "mason".setup()

vim.lsp.enable({ "lua_ls", "clangd" })

vim.diagnostic.config({
	virtual_text = true,
	underline = true,
})

-- AP CSA JAVA UTILS
vim.api.nvim_create_user_command('AP', function()
	local date = os.date("%Y-%m-%d")
	local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	local lines = {
		"// Owen Westness, " .. date .. ", " .. dir_name,
		"public class  ",
		"{",
		"    public static void main(String[] args) {",
		"        // Your code here",
		"    }",
		"}"
	}
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
	vim.api.nvim_win_set_cursor(0, { 2, 15 })
	vim.cmd('startinsert')
end, {})
