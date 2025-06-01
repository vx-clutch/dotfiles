return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim",           version = "^1.0.0" },
			{ "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
			"j-hui/fidget.nvim",
			"stevearc/conform.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"jcha0713/cmp-tw2css",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},

		config = function()
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { border = "rounded" },
			})

			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			vim.api.nvim_set_hl(0, "CmpNormal", {})
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-e>"] = vim.NIL,
				}),
				window = {
					completion = {
						scrollbar = false,
						border = "rounded",
						winhighlight = "Normal:CmpNormal",
					},
					documentation = {
						scrollbar = false,
						border = "rounded",
						winhighlight = "Normal:CmpNormal",
					},
				},
				sources = cmp.config.sources({
					{
						name = "nvim_lsp",
						max_item_count = 5,
						entry_filter = function(entry, _)
							return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind()
						end,
					},
					{ name = "cmp-tw2css" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			require("conform").setup({
				formatters_by_ft = {},
			})

			require("fidget").setup({})
			require("mason").setup()

			require("mason-lspconfig").setup({
				automatic_installation = false,
				ensure_installed = {
					"lua_ls",
					"clangd",
					"gopls",
					"rust_analyzer",
					"tinymist",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,

					["lua_ls"] = function()
						require("lspconfig").lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									runtime = { version = "Lua 5.1" },
									diagnostics = {
										globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
									},
								},
							},
						})
					end,

					["clangd"] = function()
						require("lspconfig").clangd.setup({
							capabilities = capabilities,
							cmd = { "clangd", "--header-insertion=iwyu" },
						})
					end,

					["svelte"] = function()
						require("lspconfig").svelte.setup({
							capabilities = capabilities,
							on_attach = function(client, bufnr)
								vim.api.nvim_create_autocmd("BufWritePost", {
									pattern = { "*.js", "*.ts" },
									callback = function(ctx)
										client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
									end,
								})
							end,
						})
					end,

					["tinymist"] = function()
						require("lspconfig").tinymist.setup({
							capabilities = capabilities,
							settings = {
								formatterMode = "typstyle",
								exportPdf = "never",
							},
						})
					end,
				},
			})

			local l = vim.lsp
			l.handlers["textDocument/hover"] = function(_, result, ctx, config)
				config = config or { border = "rounded", focusable = true }
				config.focus_id = ctx.method
				if not (result and result.contents) then return end
				local markdown_lines = l.util.convert_input_to_markdown_lines(result.contents)
				markdown_lines = vim.tbl_filter(function(line) return line ~= "" end, markdown_lines)
				if vim.tbl_isempty(markdown_lines) then return end
				return l.util.open_floating_preview(markdown_lines, "markdown", config)
			end

			local autocmd = vim.api.nvim_create_autocmd
			autocmd({ "BufEnter", "BufWinEnter" }, {
				pattern = { "*.vert", "*.frag" },
				callback = function() vim.cmd("set filetype=glsl") end,
			})

			autocmd("LspAttach", {
				callback = function(e)
					local opts = { buffer = e.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				end,
			})
		end,
	},
}
