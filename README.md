# nvim — Backend TypeScript Neovim Config

A production-ready Neovim configuration built for **backend/infrastructure engineers** working with TypeScript, Node.js, and Kubernetes. Forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and completely rewritten as a modular Lua config.

## Who This Is For

- Backend engineers writing TypeScript (Node.js, Fastify, NestJS)
- Teams working with Kubernetes (AKS, EKS, GKE) and Helm charts
- Developers using Azure SQL / MSSQL who want an in-editor database client
- Anyone migrating from VS Code to Neovim and wanting a batteries-included but not bloated starting point

## What's Included

| Category | Plugins | What It Does |
|---|---|---|
| **TypeScript LSP** | typescript-tools.nvim | Fast TS language server (not tsserver via lspconfig) — rename, organize imports, diagnostics |
| **Other LSPs** | nvim-lspconfig + mason | jsonls, yamlls, dockerls, helm_ls, graphql, bashls, sqlls, lua_ls — all auto-installed |
| **Schema Validation** | SchemaStore.nvim | Auto-applies JSON/YAML schemas for package.json, tsconfig, k8s manifests, docker-compose, CI configs |
| **Completion** | nvim-cmp + LuaSnip | LSP, buffer, path, and snippet completion sources |
| **AI** | copilot.vim + CopilotChat.nvim | GitHub Copilot inline suggestions (enterprise-compatible) + chat/review/explain/test generation |
| **Treesitter** | nvim-treesitter + textobjects | Syntax highlighting and text objects for 20 languages (TS, JSON, YAML, SQL, Dockerfile, Helm, etc.) |
| **Navigation** | telescope.nvim, harpoon v2, oil.nvim | Fuzzy finding, fast file switching, filesystem editing as a buffer |
| **Git** | gitsigns.nvim + lazygit (toggleterm) | Inline blame, hunk staging, and a full lazygit TUI in a float |
| **Formatting** | conform.nvim | Format on save — prettierd for TS/JSON/YAML, stylua for Lua, sql-formatter for SQL |
| **Linting** | nvim-lint | Async eslint_d for TypeScript |
| **Testing** | neotest + neotest-jest | Run nearest test, file tests, summary panel, output viewer |
| **Debugging** | nvim-dap + dap-ui + vscode-js-debug | Launch/attach Node.js processes, debug Jest tests, step through TypeScript |
| **Database** | vim-dadbod + dadbod-ui | SQL client inside Neovim — query Azure SQL/MSSQL, completion in SQL buffers |
| **Kubernetes** | Custom telescope pickers + terminal | Switch context/namespace, get pods, stream logs, describe resources |
| **API Testing** | Custom Bruno commands | Run `.bru` files, pick environments from a telescope picker |
| **Security** | Custom Snyk integration | Async SAST linter + terminal commands for `snyk test` and `snyk code test` |
| **TS Errors** | ts-error-translator.nvim | Human-readable TypeScript error messages |
| **UI** | tokyonight, lualine, indent-blankline | Minimal — no dashboard, no tabline, no notifications, no animations |
| **Editor** | which-key, undotree, nvim-surround, autopairs, Comment.nvim, trouble.nvim, todo-comments, package-info, fidget, auto-session | Quality-of-life essentials |

## Requirements

### Required

- **Neovim >= 0.10** (latest [stable](https://github.com/neovim/neovim/releases/tag/stable) recommended)
- **git**
- **make** + C compiler (gcc/clang) — for telescope-fzf-native and luasnip
- **[ripgrep](https://github.com/BurntSushi/ripgrep#installation)** — for telescope live grep
- **Node.js >= 18** + npm — for TypeScript tooling, mason installs, and DAP
- **A [Nerd Font](https://www.nerdfonts.com/)** — icons throughout the config

### Optional (enable full feature set)

| Tool | Used By | Install |
|---|---|---|
| [lazygit](https://github.com/jesseduffield/lazygit) | Git integration (`<leader>gg`) | `brew install lazygit` |
| [kubectl](https://kubernetes.io/docs/tasks/tools/) | Kubernetes keybinds (`<leader>k*`) | `brew install kubectl` |
| [Bruno CLI](https://www.usebruno.com/) | API testing (`<leader>b*`) | `npm i -g @usebruno/cli` |
| [Snyk CLI](https://docs.snyk.io/snyk-cli/install-or-update-the-snyk-cli) | Security scanning (`<leader>s*`) | `npm i -g snyk` |
| [prettierd](https://github.com/fsouza/prettierd) | Fast formatting | Auto-installed by Mason |
| [eslint_d](https://github.com/mantoni/eslint_d.js) | Fast linting | Auto-installed by Mason |
| [sql-formatter](https://github.com/sql-formatter-org/sql-formatter) | SQL formatting | Auto-installed by Mason |
| [sqlcmd](https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-utility) or [go-sqlcmd](https://github.com/microsoft/go-sqlcmd) | Dadbod MSSQL connections | `brew install sqlcmd` |
| fd | Telescope file finding (optional, faster) | `brew install fd` |

## Installation

### 1. Back up your existing config (if any)

```sh
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### 2. Clone this repo

```sh
git clone https://github.com/gabed457/nvim.git ~/.config/nvim
```

### 3. Start Neovim

```sh
nvim
```

Lazy.nvim will automatically install all plugins on first launch. Mason will install language servers and formatters. This takes a minute or two on first run.

### 4. Verify setup

Run `:checkhealth` inside Neovim to confirm everything is working. Run `:Mason` to see installed language servers and tools.

## Config Structure

```
init.lua                       -- Bootstraps lazy.nvim, loads config modules, diagnostic settings
lua/
├── config/
│   ├── options.lua            -- vim.opt settings (relative numbers, persistent undo, etc.)
│   ├── keymaps.lua            -- Non-plugin keymaps (centered scroll, line moving, etc.)
│   └── autocmds.lua           -- Autocommands (yank highlight, .bru filetype, close with q)
├── plugins/
│   ├── lsp.lua                -- typescript-tools, mason, lspconfig, SchemaStore
│   ├── completion.lua         -- nvim-cmp, LuaSnip, copilot.vim, CopilotChat
│   ├── treesitter.lua         -- Treesitter config + textobjects
│   ├── telescope.lua          -- Telescope + extensions
│   ├── git.lua                -- gitsigns, lazygit via toggleterm
│   ├── navigation.lua         -- harpoon v2, oil.nvim
│   ├── formatting.lua         -- conform.nvim, nvim-lint
│   ├── testing.lua            -- neotest + neotest-jest
│   ├── debugging.lua          -- nvim-dap + dap-ui + vscode-js-debug
│   ├── database.lua           -- vim-dadbod + dadbod-ui
│   ├── kubernetes.lua         -- kubectl telescope pickers + terminal commands
│   ├── bruno.lua              -- Bruno API testing commands
│   ├── snyk.lua               -- Snyk security integration
│   ├── ui.lua                 -- tokyonight, lualine, indent-blankline
│   └── editor.lua             -- which-key, undotree, surround, autopairs, etc.
├── snippets/
│   ├── typescript.lua         -- Async handlers, try-catch, describe/it, Fastify, NestJS
│   ├── sql.lua                -- SELECT, INSERT, UPDATE, CTE, JOIN, MSSQL TOP
│   └── yaml.lua               -- K8s Deployment, Service, Pod, ConfigMap
KEYBINDS.md                    -- Complete keybind reference
```

Each file in `lua/plugins/` is a self-contained lazy.nvim plugin spec. You can delete any file to remove that feature entirely — nothing else will break.

## Keybinds Overview

Leader key is `<Space>`. Keybinds are grouped by prefix:

| Prefix | Category | Examples |
|---|---|---|
| `<leader>f` | **Find** (telescope) | `ff` files, `fg` grep, `fb` buffers, `fs` symbols |
| `<leader>g` | **Git** | `gg` lazygit, `gs` stage hunk, `gb` blame, `gp` preview |
| `<leader>c` | **Copilot** | `cc` chat, `ce` explain, `cr` review, `ct` tests |
| `<leader>t` | **Test** | `tt` nearest, `tf` file, `ts` summary, `to` output |
| `<leader>d` | **Debug** | `db` breakpoint, `dB` conditional, `dr` REPL, `dl` last |
| `<leader>D` | **Database** | `Du` toggle Dadbod UI |
| `<leader>k` | **Kubernetes** | `kp` pods, `kl` logs, `kd` describe, `kc` context, `kn` namespace |
| `<leader>b` | **Bruno** | `br` run file, `be` run with env |
| `<leader>s` | **Snyk** | `ss` dependency scan, `sc` SAST scan |
| `<leader>x` | **Trouble** | `xx` diagnostics, `xd` buffer diagnostics |

See [KEYBINDS.md](./KEYBINDS.md) for the full reference.

## Database Setup (Azure SQL / MSSQL)

1. Install `sqlcmd` or `go-sqlcmd`
2. Open Neovim and press `<leader>Du` to open Dadbod UI
3. Add a connection with `:DBUIAddConnection`
4. Connection string format: `sqlserver://server.database.windows.net:1433/database` (AD auth is enabled by default via the `-G` flag in the config)

Dadbod completion is automatically active in SQL buffers.

## Copilot Setup

This config uses `copilot.vim` (the official GitHub plugin), **not** `copilot.lua`. This is intentional — enterprise GitHub Copilot licenses require the official plugin for auth compliance.

On first launch, run `:Copilot setup` and authenticate with your GitHub account.

## Customizing

**Add a language server:** Edit `lua/plugins/lsp.lua` — add the server name to the `servers` table and it will be auto-installed by Mason.

**Add a formatter:** Edit `lua/plugins/formatting.lua` — add it to `formatters_by_ft` in the conform config.

**Add snippets:** Create a new file in `lua/snippets/` following the LuaSnip format. See the existing files for examples.

**Change the colorscheme:** Edit `lua/plugins/ui.lua` — swap tokyonight for any other theme.

**Remove a feature:** Delete the corresponding file in `lua/plugins/`. The config is modular — nothing else depends on any single plugin file.

## What's NOT Included (by design)

- No file tree sidebar (use oil.nvim with `-` or telescope with `<leader>ff`)
- No dashboard or start screen
- No notification popups (noice.nvim)
- No tabline / bufferline
- No multiple cursors
- No animations
- No markdown preview

## Troubleshooting

- **`:checkhealth`** — first thing to run if something isn't working
- **`:Mason`** — check that language servers and tools are installed
- **`:Lazy`** — check plugin status, press `U` to update all
- **`:LspInfo`** — verify language servers are attached to the current buffer
- **`:ConformInfo`** — check which formatters are active for the current file
- **TSUpdate** — if treesitter highlighting looks wrong, run `:TSUpdate`

## Credits

Originally forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) by TJ DeVries. Rewritten for backend TypeScript infrastructure work.
