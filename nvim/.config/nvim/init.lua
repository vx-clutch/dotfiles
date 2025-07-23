-- Colorscheme & Theme
vim.cmd.colorscheme("vim")

vim.g.mapleader = " "
local opt = vim.opt

local function map(mode, lhs, rhs, opts)
        local options = { noremap = true, silent = true }
        if opts then
                options = vim.tbl_extend("force", options, opts)
        end
        vim.keymap.set(mode, lhs, rhs, options)
end

map("n", "<leader>en", ":e ~/dotfiles/nvim/.config/nvim/init.lua<CR>")  -- Edit NeoVim config file ( this file )

map("n", "<Esc>", ":nohlsearch<CR>")                                    -- Clear search highlight
map("v", "J", ":m '>+1<CR>gv=gv")                                       -- Move the current line down
map("v", "K", ":m '<-2<CR>gv=gv")                                       -- Move the current line up
map("n", "<C-d>", "<C-d>zz")                                            -- Scroll down and move cursor to center
map("n", "<C-u>", "<C-u>zz")                                            -- Scroll up and move cursor to center
map("n", "<leader>pv", ":Ex<CR>")                                       -- Open up netrw on <leader>pv
map("n", "<C-h>", "<C-w><C-h>")                                         -- Focus right
map("n", "<C-l>", "<C-w><C-l>")                                         -- Focus left
map("n", "<C-j>", "<C-w><C-j>")                                         -- Focus down
map("n", "<C-k>", "<C-w><C-k>")                                         -- Focus up
vim.keymap.set("n", "<leader>e", function()                             -- Populate then toggle the quick-fix list
  vim.diagnostic.setqflist({ open = false })
  local is_open = false
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      is_open = true
      break
    end
  end
  vim.schedule(function()
    if is_open then
      vim.cmd("cclose")
    else
      vim.cmd("copen")
    end
  end)
end)

-- Visual settings
opt.inccommand = "split"                                                -- Live substitution preview
opt.smartcase = true                                                    -- Override 'ignorecase' when pattern has uppercase
opt.ignorecase = true                                                   -- Ignore case in search
opt.number = true                                                       -- Show line numbers
opt.relativenumber = true                                               -- Show relative line numbers
opt.splitbelow = true                                                   -- New horizontal splits open below
opt.splitright = true                                                   -- New vertical splits open to the right
opt.shiftwidth = 2                                                      -- Spaces for auto-indent
opt.tabstop = 2                                                         -- Spaces for a tab character
opt.expandtab = true                                                   -- Use spaces instead of tabs
opt.scrolloff = 8                                                       -- Lines to keep above/below cursor
vim.cmd('autocmd BufEnter * set formatoptions-=cro')                    -- Disable auto-commenting on new lines
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')               -- Disable auto-commenting for local buffers
opt.wrap = false                                                        -- Do not wrap lines
opt.cursorline = true                                                   -- Highlight current line

-- File Handling
opt.swapfile = false                                                -- Disable swap file
opt.backup = false                                                  -- Don't create backup files
opt.writebackup = false                                             -- Don't create backup before writing
opt.backup = false                                                  -- Disable backup file
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"                  -- Set undo file directory
opt.undofile = true                                                 -- Enable persistent undo
opt.updatetime = 300                                                -- Faster completion
opt.autoread = true                                                 -- Auto reload files changed outside vim
opt.autowrite = false                                               -- Don't auto save

-- Behavior settings
opt.hidden = true                                                   -- Allow hidden buffers
opt.errorbells = false                                              -- No error bells
opt.backspace = "indent,eol,start"                                  -- Better backspace behavior
opt.autochdir = false                                               -- Don't auto change directory
opt.iskeyword:append("-")                                           -- Treat dash as part of word
opt.path:append("**")                                               -- include subdirectories in search

-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("vxclutch", {})

-- Return to last edit position when opening files
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

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})

-- Create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj" })

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end

-- terminal
local terminal_state = {
  buf = nil,
  win = nil,
  is_open = false
}

local function FloatingTerminal()
  -- If terminal is already open, close it (toggle behavior)
  if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
    return
  end

  -- Create buffer if it doesn't exist or is invalid
  if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
    terminal_state.buf = vim.api.nvim_create_buf(false, true)
    -- Set buffer options for better terminal experience
    vim.api.nvim_buf_set_option(terminal_state.buf, 'bufhidden', 'hide')
  end

  -- Calculate window dimensions
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create the floating window
  terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  -- Set transparency for the floating window
  vim.api.nvim_win_set_option(terminal_state.win, 'winblend', 0)

  -- Set transparent background for the window
  vim.api.nvim_win_set_option(terminal_state.win, 'winhighlight',
    'Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder')

  -- Define highlight groups for transparency
  vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none", })

  -- Start terminal if not already running
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

  -- Set up auto-close on buffer leave 
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

-- Function to explicitly close the terminal
local function CloseFloatingTerminal()
  if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
  end
end

-- Key mappings
vim.keymap.set("n", "<leader>t", FloatingTerminal, { noremap = true, silent = true})
vim.keymap.set("t", "<Esc>", function()
  if terminal_state.is_open then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
  end
end, { noremap = true, silent = true})

-- Plugins
local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require("pckr").add {
        { "williamboman/mason.nvim", build = ":MasonUpdate" },
        { "williamboman/mason-lspconfig.nvim" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "L3MON4D3/LuaSnip" },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_lsp = require("cmp_nvim_lsp")

      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
        end
        map("n", "gd", vim.lsp.buf.definition)
        map("n", "K", vim.lsp.buf.hover)
        map("n", "<leader>rn", vim.lsp.buf.rename)
        map("n", "<leader>ca", vim.lsp.buf.code_action)
      end

      local capabilities = cmp_lsp.default_capabilities()

      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "clangd" }
      }

      local servers = { "lua_ls", "clangd" }
      for _, server in ipairs(servers) do
        local opts = {
          on_attach = on_attach,
          capabilities = capabilities,
        }
        if server == "lua_ls" then
          opts.settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          }
        end
        lspconfig[server].setup(opts)
      end
    end
  },
}
