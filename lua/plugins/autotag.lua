return {
    "windwp/nvim-ts-autotag",
    ft = { "html", "xml", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("nvim-ts-autotag").setup({
            opts = {
                enable_close = true,
                enable_rename = true,
                enable_close_on_slash = true,
            },
        })
    end,
}
