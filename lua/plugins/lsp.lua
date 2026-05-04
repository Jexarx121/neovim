-- lua/plugins/lsp.lua
-- Fullstack Neovim LSP + Mason + CMP setup

return {
    -- Mason
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- Mason LSP Bridge
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "html",
                    "cssls",
                    "jsonls",
                    "intelephense",
                },
            })
        end,
    },

    -- nvim-cmp + snippets
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                }),

                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "path" },
                    { name = "luasnip" },
                }),
            })
        end,
    },

    -- Core LSP Config
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },

        config = function()
            -- Shared capabilities
            local caps = require("cmp_nvim_lsp").default_capabilities()

            -- Global defaults
            vim.lsp.config("*", {
                root_markers = { ".git" },
                capabilities = caps,
            })

            -- Diagnostics UI
            vim.diagnostic.config({
                virtual_text = true,
                severity_sort = true,
                float = {
                    style = "minimal",
                    border = "rounded",
                    source = "if_many",
                    header = "",
                    prefix = "",
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "✘",
                        [vim.diagnostic.severity.WARN] = "▲",
                        [vim.diagnostic.severity.HINT] = "⚑",
                        [vim.diagnostic.severity.INFO] = "»",
                    },
                },
            })

            -- Rounded borders
            local orig = vim.lsp.util.open_floating_preview
            ---@diagnostic disable-next-line: duplicate-set-field
            function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
                opts = opts or {}
                opts.border = opts.border or "rounded"
                opts.max_width = opts.max_width or 80
                opts.max_height = opts.max_height or 24
                opts.wrap = opts.wrap ~= false
                return orig(contents, syntax, opts, ...)
            end

            -- LSP Keymaps + Format on Save
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("my.lsp", {}),
                callback = function(args)
                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                    local buf = args.buf

                    local map = function(mode, lhs, rhs)
                        vim.keymap.set(mode, lhs, rhs, { buffer = buf })
                    end

                    map("n", "K", vim.lsp.buf.hover)
                    map("n", "gd", vim.lsp.buf.definition)
                    map("n", "gD", vim.lsp.buf.declaration)
                    map("n", "gi", vim.lsp.buf.implementation)
                    map("n", "gr", vim.lsp.buf.references)
                    map("n", "gs", vim.lsp.buf.signature_help)
                    map("n", "gl", vim.diagnostic.open_float)
                    map("n", "<F2>", vim.lsp.buf.rename)
                    map({ "n", "x" }, "<F3>", function()
                        vim.lsp.buf.format({ async = true })
                    end)
                    map("n", "<F4>", vim.lsp.buf.code_action)

                    -- Auto format
                    if client:supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = vim.api.nvim_create_augroup("my.lsp.format", { clear = false }),
                            buffer = buf,
                            callback = function()
                                vim.lsp.buf.format({
                                    bufnr = buf,
                                    id = client.id,
                                    timeout_ms = 1000,
                                })
                            end,
                        })
                    end
                end,
            })

            -- Lua
            vim.lsp.config["lua_ls"] = {
                cmd = { "lua-language-server" },
                filetypes = { "lua" },
                root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
                capabilities = caps,
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        telemetry = { enable = false },
                    },
                },
            }

            -- TypeScript / JavaScript
            vim.lsp.config["ts_ls"] = {
                cmd = { "typescript-language-server", "--stdio" },
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                },
                root_markers = {
                    "package.json",
                    "tsconfig.json",
                    "jsconfig.json",
                    ".git",
                },
                capabilities = caps,
                settings = {
                    completions = {
                        completeFunctionCalls = true,
                    },
                },
            }

            -- HTML
            vim.lsp.config["html"] = {
                cmd = { "vscode-html-language-server", "--stdio" },
                filetypes = { "html" },
                root_markers = { "package.json", ".git" },
                capabilities = caps,
            }

            -- CSS / SCSS / LESS
            vim.lsp.config["cssls"] = {
                cmd = { "vscode-css-language-server", "--stdio" },
                filetypes = { "css", "scss", "less" },
                root_markers = { "package.json", ".git" },
                capabilities = caps,
                settings = {
                    css = { validate = true },
                    scss = { validate = true },
                    less = { validate = true },
                },
            }

            -- JSON
            vim.lsp.config["jsonls"] = {
                cmd = { "vscode-json-language-server", "--stdio" },
                filetypes = { "json", "jsonc" },
                root_markers = { "package.json", ".git" },
                capabilities = caps,
            }

            -- PHP
            vim.lsp.config["intelephense"] = {
                cmd = { "intelephense", "--stdio" },
                filetypes = { "php" },
                root_markers = { "composer.json", ".git" },
                capabilities = caps,
            }

            -- Enable servers
            local servers = {
                "lua_ls",
                "ts_ls",
                "html",
                "cssls",
                "jsonls",
                "intelephense",
            }

            for _, server in ipairs(servers) do
                vim.lsp.enable(server)
            end
        end,
    },
}
