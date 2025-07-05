return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local on_attach = function(client, bufnr)
			local opts = { noremap = true, silent = true, buffer = bufnr }
			local keymap = vim.keymap

			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			keymap.set("n", "K", vim.lsp.buf.hover, opts)
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

			-- Svelte-specific watcher: notify svelte LS on JS/TS writes
			if client.name == "svelte" then
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
					end,
					buffer = bufnr,
					desc = "Notify svelte language server of TS/JS file changes",
				})
			end
		end

		local lspconfig = require("lspconfig")

		local servers = {
			clangd = {},
			lua_ls = {
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			},
			pyright = {
				settings = {
					pyright = {
						typeCheckingMode = "basic",
					},
				},
			},
			graphql = {
				filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
			},
			emmet_ls = {
				filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
			},
			svelte = {},
		}

		for server, config in pairs(servers) do
			config.on_attach = on_attach
			config.capabilities = capabilities
			lspconfig[server].setup(config)
		end

		-- Diagnostics UI config
		vim.diagnostic.config({
			float = { source = true, border = "single" },
		})

		-- Optional: hover window styling
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "single",
		})
	end,
}
