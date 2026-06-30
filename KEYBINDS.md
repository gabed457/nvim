# Keybinds Reference

Leader key: `<Space>`

> New here? Run `:Tutorial` (or press `<leader>?`) for the interactive, hands-on tour of this config.

## General

| Key | Description |
|---|---|
| `<Esc>` | Clear search highlight |
| `<leader>q` | Open diagnostic quickfix list |
| `<Esc><Esc>` | Exit terminal mode |
| `<C-d>` | Scroll down (centered) |
| `<C-u>` | Scroll up (centered) |
| `n` / `N` | Next/prev search match (centered) |
| `J` (visual) | Move selection down |
| `K` (visual) | Move selection up |
| `<leader><leader>` | Open buffer picker |
| `<leader>/` | Fuzzy search in current buffer |

## Windows

| Key | Description |
|---|---|
| `<C-h>` | Move focus to left window |
| `<C-l>` | Move focus to right window |
| `<C-j>` | Move focus to window below |
| `<C-k>` | Move focus to window above |

## Search / Telescope (`<leader>s`)

| Key | Description |
|---|---|
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep |
| `<leader>sb` | Buffers |
| `<leader>ss` | LSP document symbols |
| `<leader>sS` | LSP workspace symbols |
| `<leader>sd` | Diagnostics |
| `<leader>sk` | Keymaps |
| `<leader>sr` | Resume last search |
| `<leader>sh` | Help tags |
| `<leader>sw` | Grep word under cursor |

## LSP

| Key | Description |
|---|---|
| `gd` | Go to definition |
| `gr` | References |
| `gi` | Implementation |
| `gD` | Go to declaration |
| `K` | Hover documentation |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename |
| `<leader>D` | Type definition |
| `<leader>f` | Format buffer |
| `<leader>th` | Toggle inlay hints |

## Git (`<leader>g`)

| Key | Description |
|---|---|
| `<leader>gg` | Open Lazygit (floating) |
| `<leader>gs` | Stage hunk (also visual) |
| `<leader>gu` | Undo stage hunk |
| `<leader>gr` | Reset hunk (also visual) |
| `<leader>gS` | Stage buffer |
| `<leader>gR` | Reset buffer |
| `<leader>gp` | Preview hunk |
| `<leader>gb` | Blame line (full) |
| `<leader>gd` | Diff this |
| `<leader>gv` | Diffview: diff unstaged |
| `<leader>gc` | Diffview: diff staged |
| `<leader>gf` | Diffview: file history |
| `<leader>gq` | Diffview: close |
| `]c` / `[c` | Next/prev hunk (in a git file) |

## Navigation

| Key | Description |
|---|---|
| `<leader>a` | Harpoon: add current file |
| `<leader>h` | Harpoon: toggle quick menu |
| `<leader>1` | Harpoon: jump to file 1 |
| `<leader>2` | Harpoon: jump to file 2 |
| `<leader>3` | Harpoon: jump to file 3 |
| `<leader>4` | Harpoon: jump to file 4 |
| `<leader>e` | Oil: toggle file explorer |
| `-` | Oil: go to parent directory |
| `<CR>` | Oil: open file/dir under cursor |
| `g.` | Oil: toggle hidden files |
| `g?` | Oil: show help |

## Trouble / Diagnostics (`<leader>x`)

| Key | Description |
|---|---|
| `<leader>xx` | Toggle diagnostics list |
| `<leader>xd` | Buffer-only diagnostics |
| `<leader>xp` | Swap parameter forward |
| `<leader>xP` | Swap parameter backward |

## Editor

| Key | Description |
|---|---|
| `<leader>u` | Toggle undotree |
| `<leader>ct` | Toggle cloak (hide `.env` values) |
| `gcc` | Toggle line comment |
| `gc` (visual) | Toggle comment on selection |
| `ys{motion}{char}` | Add surround |
| `cs{old}{new}` | Change surround |
| `ds{char}` | Delete surround |

## Neovim / Config (`<leader>n`)

| Key | Description |
|---|---|
| `<leader>nu` | Update Neovim config from remote |
| `<leader>?` | Open the interactive tutorial |

## Completion (Insert Mode)

| Key | Description |
|---|---|
| `<C-n>` | Next completion item |
| `<C-p>` | Previous completion item |
| `<CR>` | Confirm completion |
| `<C-Space>` | Trigger completion |
| `<C-e>` | Abort completion |
| `<C-b>` | Scroll docs up |
| `<C-f>` | Scroll docs down |
| `<C-l>` | Jump forward in snippet |
| `<C-h>` | Jump backward in snippet |

## Treesitter Text Objects

| Key | Description |
|---|---|
| `af` / `if` | Around/inner function |
| `ac` / `ic` | Around/inner class |
| `aa` / `ia` | Around/inner parameter |
| `ai` / `ii` | Around/inner conditional |
| `al` / `il` | Around/inner loop |
| `]f` / `[f` | Next/prev function start |
| `]a` / `[a` | Next/prev parameter |
| `<C-space>` | Start / grow incremental selection |
| `<BS>` | Shrink incremental selection |

> Note: `]c` / `[c` jump between git hunks when gitsigns is attached (a git-tracked
> file). Treesitter also maps `]c` / `[c` to class motions — these only take effect
> in buffers without gitsigns (e.g. files outside a git repo).

## Snippets (expand by typing the trigger, then `<C-l>` to jump)

| Filetype | Trigger | Expands to |
|---|---|---|
| TypeScript | `asynchandler` | Async Fastify handler with try/catch |
| TypeScript | `trycatch` | try/catch block |
| TypeScript | `desc` | `describe`/`it` test scaffold |
| TypeScript | `it` | Single `it` test block |
| TypeScript | `froute` | Fastify route plugin |
| TypeScript | `fplugin` | Fastify plugin (`fastify-plugin`) |
| TypeScript | `nestmethod` | NestJS controller method |
| SQL | `sel` | SELECT … FROM … WHERE |
| SQL | `ins` | INSERT INTO |
| SQL | `upd` | UPDATE … SET … WHERE |
| SQL | `cte` | WITH … AS ( … ) CTE |
| SQL | `join` | SELECT with INNER JOIN |
| SQL | `top` | SELECT TOP N (MSSQL) |
