return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    lazy = false,
    opts = {
	indent = { enable = true },
	highlight = { enable = true },
	ensure_installed = {
	    "lua",
	    "tsx",
	    "typescript",
	    "javascript",
	    "html"
	}
    }
}

