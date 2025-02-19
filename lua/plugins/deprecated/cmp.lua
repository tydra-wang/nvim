return {
    -- auto completion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
        },
        opts = function()
            local cmp = require "cmp"
            local defaults = require "cmp.config.default"()
            return {
                -- completion = {
                --     completeopt = "menu,menuone,noinsert,preview",
                -- },
                mapping = cmp.mapping.preset.insert {
                    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-c>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm { select = true },
                    ["<S-CR>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                sources = cmp.config.sources {
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "nvim_lua" },
                    { name = "buffer" },
                },
                sorting = defaults.sorting,
            }
        end,
    },

    -- icons
    {
        "nvim-cmp",
        dependencies = {
            "onsails/lspkind.nvim",
        },
        opts = function(_, opts)
            opts.formatting = {
                format = require("lspkind").cmp_format {},
            }
        end,
    },

    -- snippets
    {
        "nvim-cmp",
        dependencies = {
            {
                "garymjr/nvim-snippets",
                opts = {
                    friendly_snippets = true,
                },
                dependencies = { "rafamadriz/friendly-snippets" },
            },
        },
        opts = function(_, opts)
            opts.snippet = {
                expand = function(item)
                    return vim.snippet.expand(item.body)
                end,
            }
            table.insert(opts.sources, { name = "snippets" })
        end,

        keys = {
            {
                "<Tab>",
                function()
                    if vim.snippet.active { direction = 1 } then
                        vim.schedule(function()
                            vim.snippet.jump(1)
                        end)
                        return
                    end
                    return "<Tab>"
                end,
                expr = true,
                silent = true,
                mode = "i",
            },
            {
                "<Tab>",
                function()
                    vim.schedule(function()
                        vim.snippet.jump(1)
                    end)
                end,
                expr = true,
                silent = true,
                mode = "s",
            },
            {
                "<S-Tab>",
                function()
                    if vim.snippet.active { direction = -1 } then
                        vim.schedule(function()
                            vim.snippet.jump(-1)
                        end)
                        return
                    end
                    return "<S-Tab>"
                end,
                expr = true,
                silent = true,
                mode = { "i", "s" },
            },
        },
    },
}
