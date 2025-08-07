local lspconfig = require("lspconfig")

local cmp = require("cmp")
local cmp_lsp = require("cmp_nvim_lsp")

-- autocompletion
local capabilities = cmp_lsp.default_capabilities()

-- Setup language servers
lspconfig.lua_ls.setup({
  capabilities = capabilities,
})

lspconfig.ts_ls.setup({
  capabilities = capabilities,
})

lspconfig.html.setup({
  capabilities = capabilities,
})

lspconfig.cssls.setup({
  capabilities = capabilities,
})

lspconfig.tailwindcss.setup({
  capabilities = capabilities,
})

lspconfig.pyright.setup({
  capabilities = capabilities,
})

lspconfig.emmet_ls.setup({
  capabilities = capabilities,
  filetypes = {
	  "html",
	  "css",
	  "javascript",
	  "javascriptreact",
	  "typescriptreact"
  }
})

-- nvim-cmp completion config
cmp.setup({
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
})
