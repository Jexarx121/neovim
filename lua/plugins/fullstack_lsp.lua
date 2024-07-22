-- lua/plugins/fullstack.lua

return {
  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- TypeScript server setup
      lspconfig.tsserver.setup({})

      -- Prisma LSP setup
      lspconfig.prismals.setup({})

      -- Add additional LSP server configurations as needed
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
      })
    end,
  },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "javascript", "typescript", "lua", "prisma" },
        highlight = { enable = true },
      })
    end,
  },

  -- Prisma syntax support
  { "pantharshit00/vim-prisma" },

  -- Additional plugins can be added here as necessary
}
