vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")
vim.keymap.set("n", "<leader>en", ":edit $MYVIMRC<CR>")
vim.keymap.set("n", "<leader>ez", ":edit ~/.zshrc<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

for _, k in ipairs({ "h", "j", "k", "l" }) do
    vim.keymap.set({ "n", "i", "v" }, "<C-" .. k .. ">", "<C-w><C-" .. k .. ">")
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "blazkowolf/gruber-darker.nvim",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("gruber-darker")
        end,
    },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        config = function()
            local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            local capabilities = ok and cmp_nvim_lsp.default_capabilities() or
                vim.lsp.protocol.make_client_capabilities()

            local servers = { "lua_ls", "clangd", "pyright", "gopls" }

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = servers,
            })

            for _, name in ipairs(servers) do
                local cfg = { capabilities = capabilities }

                if name == "lua_ls" then
                    cfg.settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                        },
                    }
                end

                local server_cfg = vim.lsp.config[name]
                if not server_cfg then
                    vim.notify("LSP server config not found: " .. name, vim.log.levels.WARN)
                else
                    local cmd = server_cfg.cmd or { name }
                    vim.lsp.start(vim.tbl_extend("force", cfg, {
                        name = name,
                        cmd = cmd,
                        root_dir = vim.fs.root(0, { ".git", "Makefile", "main.c", "go.mod" }),
                        settings = cfg.settings,
                    }))
                end
            end
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            picker = { enabled = true },
            quickfile = { enabled = true },
            terminal = {
                enabled = true,
                float = {
                    border = "rounded",
                    width = 0.8,
                    height = 0.8,
                },
            },
        },
        config = function(_, opts)
            require("snacks").setup(opts)
            vim.keymap.set("n", "<C-_>", function()
                require("snacks.terminal").toggle(nil, { float = true })
            end)
            vim.keymap.set("t", "<C-_>", function()
                require("snacks.terminal").toggle(nil, { float = true })
            end)
        end,
    },
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function ()
	local builtin = require("telescope.builtin")
      	require("telescope").setup {}
	vim.keymap.set("n", "<leader>g", builtin.live_grep)
	vim.keymap.set("n", "<leader>s", builtin.find_files)
      end
    },
})

vim.diagnostic.config { virtual_text = true, underline = true, signs = false }
