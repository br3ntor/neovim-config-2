return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
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

		vim.lsp.config("*", {
			on_attach = on_attach,
			capabilities = capabilities,
		})

		-- Setup servers:
		vim.lsp.config("lua_ls", {
			on_attach = on_attach,
			capabilities = capabilities,
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
		})

		vim.lsp.config("pyright", {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				pyright = {
					typeCheckingMode = "basic",
				},
			},
		})

		vim.lsp.config("graphql", {
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		vim.lsp.config("emmet_ls", {
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

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
