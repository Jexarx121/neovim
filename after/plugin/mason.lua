require('mason').setup()

require('mason-lspconfig').setup({
	ensure_installed = {
		"lua_ls",
		"ts_ls",
		"html",
		"cssls",
		"pyright",
		"tailwindcss",
		"emmet_ls"

	},
	automatic_installation = true
})
