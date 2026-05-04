return {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup()
        vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)")
        vim.keymap.set("x", "<leader>/", "<Plug>(comment_toggle_linewise_visual)")
    end,
}
