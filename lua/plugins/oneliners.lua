return {
    { -- helps with ssh tunneling and copying to clipboard
        'ojroques/vim-oscyank',
        config = function()
            vim.keymap.set('v', '<leader>y', '<Plug>OSCYankVisual')
        end
    },
    { -- Git plugin
        'tpope/vim-fugitive',
    },
    { -- Show CSS Colors
        'brenoprata10/nvim-highlight-colors',
        config = function()
            require('nvim-highlight-colors').setup({})
        end
    },
}
