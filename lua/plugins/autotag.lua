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

        local filetypes = { html = true, xml = true, javascriptreact = true, typescriptreact = true, javascript = true, typescript = true }

        local function setup_keymaps()
            vim.keymap.set("i", "<CR>", function()
                local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                local line = vim.api.nvim_get_current_line()
                local before = line:sub(1, col)
                local after = line:sub(col + 1)

                if before:match(">$") and after:match("^</") then
                    local indent = line:match("^(%s*)")
                    local inner = indent .. string.rep(" ", vim.bo.shiftwidth)
                    local bufnr = vim.api.nvim_get_current_buf()

                    vim.api.nvim_set_current_line(before)
                    vim.api.nvim_buf_set_lines(bufnr, row, row, false, { inner, indent .. after })
                    vim.api.nvim_win_set_cursor(0, { row + 1, #inner })
                else
                    vim.api.nvim_feedkeys(
                        vim.api.nvim_replace_termcodes("<CR>", true, false, true),
                        "n",
                        false
                    )
                end
            end, { buffer = true })

            vim.keymap.set("n", "o", function()
                local row = vim.api.nvim_win_get_cursor(0)[1]
                local indent = vim.api.nvim_get_current_line():match("^(%s*)")
                vim.api.nvim_buf_set_lines(0, row, row, false, { indent })
                vim.api.nvim_win_set_cursor(0, { row + 1, #indent })
                vim.cmd("startinsert!")
            end, { buffer = true })

            vim.keymap.set("n", "O", function()
                local row = vim.api.nvim_win_get_cursor(0)[1]
                local indent = vim.api.nvim_get_current_line():match("^(%s*)")
                vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { indent })
                vim.api.nvim_win_set_cursor(0, { row, #indent })
                vim.cmd("startinsert!")
            end, { buffer = true })
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = vim.tbl_keys(filetypes),
            callback = setup_keymaps,
        })

        if filetypes[vim.bo.filetype] then
            setup_keymaps()
        end
    end,
}
