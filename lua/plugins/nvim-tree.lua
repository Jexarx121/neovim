return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- disable netrw so nvim-tree takes over
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            require("nvim-tree").setup({
                view = {
                    width = 35,
                    side = "left",
                },
                renderer = {
                    group_empty = true,
                    icons = {
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                            git = true,
                        },
                    },
                },
                git = {
                    enable = true,
                    ignore = false,
                },
                filters = {
                    dotfiles = false,
                },
                filesystem_watchers = {
                    ignore_dirs = {
                        "node_modules", ".next", ".git",
                        -- Unity: metadata cache + build/editor scratch dirs
                        "Library", "Temp", "obj", "Obj", "Logs", ".vs", "UserSettings", "Build", "Builds",
                    },
                },
                actions = {
                    open_file = {
                        quit_on_open = false,
                    },
                },
            })

            vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
            vim.keymap.set("n", "<leader>cd", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" })
        end,
    },
}
