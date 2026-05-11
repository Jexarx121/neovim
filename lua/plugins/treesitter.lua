return {
    "nvim-treesitter/nvim-treesitter",
    commit = "310f0925ec64c7e54f3ee952679d285b13e5a735",
    build = ":TSUpdate",
    lazy = false,

    config = function()
        require("nvim-treesitter.install").compilers = { "gcc" }

        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua",
                "tsx",
                "typescript",
                "javascript",
                "html",
                "xml",
            },

            highlight = {
                enable = true,
                disable = function(_, buf)
                    local path = vim.api.nvim_buf_get_name(buf)
                    return path:match("node_modules") or path:match("%.next")
                end,
            },

            indent = {
                enable = true,
            },
        })
    end,
}
