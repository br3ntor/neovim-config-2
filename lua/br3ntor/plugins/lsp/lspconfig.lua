return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

		vim.lsp.config("lua_ls", {
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
			settings = {
				pyright = {
					typeCheckingMode = "basic",
				},
			},
		})

		vim.lsp.config("graphql", {
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		vim.lsp.config("emmet_ls", {
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		local servers = {
			"ts_ls",
			"clangd",
			"lua_ls",
			"pyright",
			"graphql",
			"emmet_ls",
			"svelte",
			"tailwindcss",
			"yamlls",
		}

		for _, server in ipairs(servers) do
			vim.lsp.enable(server)
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local opts = { noremap = true, silent = true, buffer = ev.buf }
				local keymap = vim.keymap

				keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = ev.buf })
				keymap.set(
					"n",
					"gd",
					"<cmd>Telescope lsp_definitions<CR>",
					{ desc = "Go to definition", buffer = ev.buf }
				)
				keymap.set(
					"n",
					"<leader>D",
					"<cmd>Telescope diagnostics bufnr=0<CR>",
					{ desc = "Buffer diagnostics", buffer = ev.buf }
				)
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics", buffer = ev.buf })

				keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1 })
				end, { desc = "Previous diagnostic", buffer = ev.buf })

				keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1 })
				end, { desc = "Next diagnostic", buffer = ev.buf })

				keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP", buffer = ev.buf })

				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client and client.name == "svelte" then
					vim.api.nvim_create_autocmd("BufWritePost", {
						pattern = { "*.js", "*.ts" },
						callback = function(ctx)
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
						end,
						buffer = ev.buf,
						desc = "Notify svelte language server of TS/JS file changes",
					})
				end
			end,
		})

		vim.diagnostic.config({
			float = { source = true, border = "single" },
		})
	end,
}
