return {
    {
	"neanias/everforest-nvim",
	config = function()
	    vim.cmd.colorscheme "everforest"
	end

    },
    {
	"nvim-lualine/lualine.nvim",
	dependencies = {
	    "nvim-tree/nvim-web-devicons"
	},
	opts = {
	    theme = 'everforest'
	},
    },
}
