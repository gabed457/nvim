# Keybinds Reference

Leader key: `<Space>`

## General

| Key | Description |
|---|---|
| `<Esc>` | Clear search highlight |
| `<leader>q` | Open diagnostic quickfix list |
| `<Esc><Esc>` | Exit terminal mode |
| `<C-d>` | Scroll down (centered) |
| `<C-u>` | Scroll up (centered) |
| `J` (visual) | Move selection down |
| `K` (visual) | Move selection up |
| `<leader><leader>` | Open buffers |
| `<leader>/` | Fuzzy search in current buffer |

## Find / Telescope (`<leader>f`)

| Key | Description |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fs` | LSP document symbols |
| `<leader>fS` | LSP workspace symbols |
| `<leader>fd` | Diagnostics |
| `<leader>fk` | Keymaps |
| `<leader>fr` | Resume last search |
| `<leader>fh` | Help tags |
| `<leader>fw` | Grep word under cursor |

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
| `<leader>gg` | Open Lazygit |
| `<leader>gs` | Stage hunk |
| `<leader>gu` | Undo stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gS` | Stage buffer |
| `<leader>gR` | Reset buffer |
| `<leader>gp` | Preview hunk |
| `<leader>gb` | Blame line |
| `<leader>gd` | Diff this |
| `]c` | Next hunk |
| `[c` | Previous hunk |

## Navigation

| Key | Description |
|---|---|
| `<leader>a` | Harpoon: Add file |
| `<leader>h` | Harpoon: Toggle menu |
| `<C-h>` | Harpoon: File 1 |
| `<C-j>` | Harpoon: File 2 |
| `<C-k>` | Harpoon: File 3 |
| `<C-l>` | Harpoon: File 4 |
| `<leader>e` | Oil: Toggle file explorer (current file dir) |
| `-` | Oil: Open parent directory |

## Trouble / Diagnostics (`<leader>x`)

| Key | Description |
|---|---|
| `<leader>xx` | Toggle diagnostics list |
| `<leader>xd` | Buffer diagnostics |
| `<leader>xp` | Swap parameter forward |
| `<leader>xP` | Swap parameter backward |

## Neovim (`<leader>n`)

| Key | Description |
|---|---|
| `<leader>nu` | Update Neovim config from remote |

## Editor

| Key | Description |
|---|---|
| `<leader>ct` | Toggle cloak (hide .env values) |
| `<leader>u` | Toggle undotree |
| `gcc` | Toggle line comment |
| `gc` (visual) | Toggle comment |
| `ys{motion}{char}` | Add surround |
| `cs{old}{new}` | Change surround |
| `ds{char}` | Delete surround |

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
| `]c` / `[c` | Next/prev class start |
| `<C-space>` | Incremental selection |
| `<BS>` | Decrement selection |
