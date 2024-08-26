return {
    {
        "echasnovski/mini.pairs",
        config = true,
        event = "InsertEnter",
    },

    -- auto completion
    {
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            -- sources
            {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                -- "hrsh7th/cmp-cmdline",
                "hrsh7th/cmp-nvim-lua",
            },
            -- icons
            "onsails/lspkind.nvim",
            "dcampos/cmp-snippy",
            "dcampos/nvim-snippy",
        },
        opts = function()
            local cmp = require "cmp"
            local defaults = require "cmp.config.default"()
            return {
                snippet = {
                    expand = function(args)
                        require("snippy").expand_snippet(args.body)
                    end,
                },
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
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "nvim_lua" },
                    { name = "snippy" },
                },
                formatting = {
                    format = require("lspkind").cmp_format {},
                },
                sorting = defaults.sorting,
            }
        end,
        config = function(_, opts)
            local cmp = require "cmp"
            cmp.setup(opts)

            -- cmp.setup.cmdline({ "/", "?" }, {
            --     mapping = cmp.mapping.preset.cmdline(),
            --     sources = {
            --         { name = "buffer" },
            --     },
            -- })
            --
            -- cmp.setup.cmdline(":", {
            --     mapping = cmp.mapping.preset.cmdline(),
            --     sources = cmp.config.sources({
            --         { name = "path" },
            --     }, {
            --         {
            --             name = "cmdline",
            --             option = {
            --                 ignore_cmds = { "Man", "!" },
            --             },
            --         },
            --     }),
            -- })
        end,
    },
}
