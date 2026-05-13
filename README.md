# Neovim Fullstack Config

A Neovim setup tailored for fullstack web development, with LSP support for TypeScript, HTML, CSS, JSON, Lua, and PHP.

**Leader key:** `Space`

---

## Plugins

| Plugin | Purpose |
|---|---|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [everforest-nvim](https://github.com/neanias/everforest-nvim) | Color scheme |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File icons |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | Auto-close/rename HTML tags |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [harpoon](https://github.com/ThePrimeagen/harpoon) | Quick file navigation |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippets |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Snippet library |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Toggle comments |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/tool installer |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configuration |
| [nvim-highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors) | Inline color preview |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git integration |
| [vim-oscyank](https://github.com/ojroques/vim-oscyank) | SSH clipboard support |

**LSP servers:** `ts_ls`, `html`, `cssls`, `jsonls`, `lua_ls`, `intelephense`

---

## Hotkeys

### File Navigation
| Key | Action |
|---|---|
| `<leader>e` | Toggle file explorer |
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Live grep |
| `<leader>fb` | Browse open buffers |
| `<leader>fh` | Search help tags |
| `<leader>a` | Add file to Harpoon |
| `<C-e>` | Harpoon quick menu |
| `<C-n>` / `<C-p>` | Next / previous Harpoon file |

### LSP
| Key | Action |
|---|---|
| `K` | Hover docs |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Go to references |
| `gl` | Diagnostic float |
| `<F2>` | Rename symbol |
| `<F3>` | Format document |
| `<F4>` | Code action |

### Completion
| Key | Action |
|---|---|
| `<C-Space>` | Trigger completion |
| `<Tab>` / `<S-Tab>` | Next / previous item |
| `<CR>` | Confirm selection |
| `<C-b>` / `<C-f>` | Scroll docs up / down |

### Terminal
| Key | Action |
|---|---|
| `<leader>t` | Open new terminal |
| `<leader>td` | Delete terminal |
| `<leader>st` | Toggle all terminals |
| `<C-l>` / `<C-h>` | Next / previous terminal |
| `<Esc>` | Exit terminal insert mode |

### Editing
| Key | Action |
|---|---|
| `<leader>/` | Toggle comment (line or selection) |
| `<leader>y` | Yank to clipboard via OSC52 (SSH-safe) |
