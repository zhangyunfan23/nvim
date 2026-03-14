# nvim config

Personal Neovim configuration built on [LazyVim](https://www.lazyvim.org/), with extra plugins for file management, fuzzy finding, and Python/Lua development.

## Requirements

- Neovim >= 0.10
- Git
- [Nerd Font](https://www.nerdfonts.com/) (for icons)
- `yazi` (optional, for file browser)
- `fzf` (optional, for fuzzy grep)

## Install

```bash
git clone https://github.com/zhangyunfan23/nvim.git ~/.config/nvim
nvim  # lazy.nvim will auto-install plugins on first launch
```

## Key Plugins

| Plugin | Purpose |
|---|---|
| LazyVim | Base framework + defaults |
| nvim-tree | File explorer |
| yazi.nvim | Terminal file browser |
| Telescope + fzf-lua | Fuzzy finding |
| nvim-treesitter | Syntax highlighting |
| Mason + nvim-lspconfig | LSP / language servers |
| nvim-cmp | Autocompletion |
| Snacks.nvim | Floating terminal + utilities |

## Keymaps

| Key | Action |
|---|---|
| `<C-s>` | Save file (normal & insert mode) |
| `<leader>q` | Quit |
| `jj` | Exit insert mode |
| `<leader>e` | Toggle file explorer (nvim-tree) |
| `<leader>-` | Open yazi at current file |
| `<leader>fy` | Open yazi at project root |
| `<C-Up>` | Resume last yazi session |
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Live grep (Telescope) |

> All default LazyVim keymaps are also available. See [LazyVim keymaps](https://www.lazyvim.org/keymaps).

## VSCode

The config detects VSCode (via `vim.g.vscode`) and loads a minimal setup (`lua/vscode.lua`) with only clipboard and line number settings — no plugins.
