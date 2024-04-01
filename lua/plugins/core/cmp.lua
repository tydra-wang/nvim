return {
    {
        "echasnovski/mini.pairs",
        config = true,
        event = "InsertEnter",
    },

    -- snippets
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true,
                silent = true,
                mode = "i",
            },
            {
                "<tab>",
                function()
                    require("luasnip").jump(1)
                end,
                mode = "s",
            },
            {
                "<s-tab>",
                function()
                    require("luasnip").jump(-1)
                end,
                mode = { "i", "s" },
            },
        },
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
                "hrsh7th/cmp-cmdline",
                "hrsh7th/cmp-nvim-lua",
            },
            -- icons
            "onsails/lspkind.nvim",
            -- lsp signature
            {
                "ray-x/lsp_signature.nvim",
                enabled = false,
                opts = {
                    hint_enable = false,
                },
            },
        },
        opts = function()
            local cmp = require "cmp"
            local defaults = require "cmp.config.default"()
            return {
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
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
