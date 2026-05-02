# Neovim Configuration

A modern Neovim setup with automated plugin management, LSP, formatting, and linting.

## System Dependencies

These must be installed before first use:

| Dependency | Purpose |
|------------|---------|
| `gcc` | Compiler for Treesitter C parsers |
| `ripgrep` | Telescope live_grep backend |
| `fd` | Telescope find_files backend |
| `node` + `npm` | LSP servers (ts_ls, etc.) |
| `python3` + `venv` | pyright, ruff, etc. |
| `make` | telescope-fzf-native build |

## Quick Setup

Run the setup script to install all system dependencies:

```bash
bash setup.sh
```

### Manual Installation

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install -y gcc ripgrep fd-find nodejs npm python3 python3-venv make
# Ubuntu installs fd as fdfind, add symlink if needed:
sudo ln -sf $(which fdfind) /usr/local/bin/fd 2>/dev/null || true
```

**Arch Linux:**
```bash
sudo pacman -Syu gcc ripgrep fd nodejs npm python python-virtualenv make
```

## Automated Features

Everything below is **automatically installed/managed** on first run:

### Plugin Manager (lazy.nvim)
- Auto-bootstraps on first Neovim start
- Plugins defined in `lua/br3ntor/plugins/`
- Run `:Lazy update` to update plugins

### LSP Servers (via Mason)
Auto-installed: ts_ls, lua_ls, html, cssls, tailwindcss, svelte, graphql, emmet_ls, prismals, pyright, jsonls, clangd, bashls, eslint, gopls, sqls

### Formatters (via Mason + conform.nvim)
Auto-installed: prettier, stylua, black, isort, ruff, shellcheck, sql-formatter, clang-format, yamllint
- Format-on-save enabled with `lsp_fallback = true`

### Treesitter Parsers
Auto-installed: c, json, javascript, typescript, tsx, yaml, html, css, prisma, markdown, svelte, graphql, bash, lua, vim, vimdoc, dockerfile, gitignore, query, python, go
- Parsers auto-install when opening new file types (`auto_install = true`)

## First Run

1. Start Neovim: `nvim`
2. lazy.nvim will auto-bootstrap
3. All plugins will be cloned and installed
4. Mason will install LSP servers, formatters, and linters
5. Treesitter parsers install on first use

## Key Conventions

- Leader key: `<Space>`
- TS/JS files: 2-space indent
- Other files: 4-space indent
- File explorer: nvim-tree (`<leader>e`)
- netrw disabled

## Structure

- `init.lua` — entrypoint
- `lua/br3ntor/core/` — keymaps and options
- `lua/br3ntor/lazy.lua` — plugin manager bootstrap
- `lua/br3ntor/plugins/` — one file per plugin
- `lua/br3ntor/plugins/lsp/` — LSP configuration
