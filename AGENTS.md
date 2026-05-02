# AGENTS.md

## Structure

- `init.lua` — entrypoint; branches on `vim.g.vscode` (loads nothing for VSCode, full config otherwise)
- `lua/br3ntor/core/` — keymaps and options loaded first
- `lua/br3ntor/lazy.lua` — bootstraps lazy.nvim, sets leader to `<Space>`, imports plugin specs
- `lua/br3ntor/plugins/` — one file per plugin, each returns a lazy.nvim spec table
- `lua/br3ntor/plugins/lsp/` — LSP sub-module (mason, lspconfig, lazydev)

## Conventions

- Plugin specs are one-per-file under `lua/br3ntor/plugins/`, each `return { ... }` (lazy.nvim format)
- Leader key is `<Space>` (set in both `core/keymaps.lua` and `lazy.lua`)
- TS/JS files use 2-space indent; everything else uses 4-space (set via FileType autocmd in `core/options.lua`)
- netrw is disabled (`loaded_netrw = 1`); nvim-tree is the file explorer (`<leader>e`)
- Format-on-save is enabled via conform.nvim with `lsp_fallback = true`

## Key Dependencies

- **Plugin manager**: lazy.nvim (auto-bootstrapped)
- **LSP servers**: managed by mason.nvim; `automatic_enable = false` in mason-lspconfig, servers are explicitly enabled via `vim.lsp.enable()` in `lspconfig.lua`
- **Formatters**: prettier (JS/TS/Svelte/CSS/HTML/JSON/YAML/MD/GraphQL), stylua (Lua), black+isort (Python), sql-formatter, clang-format
- **Linters**: ruff (Python), shellcheck (Bash), yamllint (YAML) — eslint is commented out
- **Telescope**: requires ripgrep and fd installed on the system; fzf-native extension needs `make` to build
- **Treesitter**: `:TSUpdate` is the build command; ensure_installed lists are in `treesitter.lua`

## System Prerequisites

These must be installed outside Neovim (from README):
- gcc (compiler for treesitter C parsers)
- ripgrep, fd (telescope backends)
- node + npm (LSP servers like ts_ls)
- python3 + venv (pyright, ruff, etc.)
- make (telescope-fzf-native build)

## Avante.nvim

- Currently `enabled = false`
- Uses a custom Ollama vendor pointing to `http://192.168.0.212:11434` with `qwen2.5-coder:7b`
- Build step is `make` (from source)

## Svelte LSP Quirk

The svelte LSP needs `$/onDidChangeTsOrJsFile` notification on JS/TS file saves to stay in sync — handled via LspAttach autocmd in `lspconfig.lua`.
