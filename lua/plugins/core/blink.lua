return {
    {
        "hrsh7th/nvim-cmp",
        optional = true,
        enabled = false,
    },
    {
        "saghen/blink.cmp",
        -- cond = false,
        version = "1.*",
        -- build = "cargo build --release",
        opts_extend = {
            "sources.completion.enabled_providers",
            -- "sources.compat",
            "sources.default",
        },
        dependencies = {
            "rafamadriz/friendly-snippets",
            "Kaiser-Yang/blink-cmp-dictionary",
            -- add blink.compat to dependencies
            -- {
            --     "saghen/blink.compat",
            --     optional = true, -- make optional so it's only enabled if any extras need it
            --     opts = {},
            --     -- version = "*",
            -- },
        },
        event = "InsertEnter",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            appearance = {
                -- sets the fallback highlight groups to nvim-cmp's highlight groups
                -- useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release, assuming themes add support
                -- use_nvim_cmp_as_default = false,

                -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- adjusts spacing to ensure icons are aligned
                -- nerd_font_variant = "mono",
            },
            completion = {
                -- accept = {
                --     -- experimental auto-brackets support
                --     auto_brackets = {
                --         enabled = true,
                --     },
                -- },
                -- menu = {
                --     draw = { treesitter = { "lsp" } },
                -- border = "single",
                -- },
                documentation = {
                    -- window = { border = "single" },
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                -- ghost_text = {
                --     enabled = vim.g.ai_cmp,
                -- },
            },

            -- experimental signature help support
            signature = {
                enabled = true,
                -- window = { border = "single" },
            },

            sources = {
                default = { "lsp", "path", "snippets", "buffer", "dictionary" },
                providers = {
                    dictionary = {
                        module = "blink-cmp-dictionary",
                        min_keyword_length = 3,
                    },
                },
            },
            fuzzy = { implementation = "prefer_rust" },

            -- cmdline = {
            --     enabled = false,
            -- },

            keymap = {
                preset = "super-tab",
                -- preset = "default",
                -- ["<C-y>"] = { "select_and_accept" },
            },
        },
    },

    {
        "saghen/blink.cmp",
        opts = {
            sources = {
                -- add lazydev to your completion providers
                default = { "lazydev" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100, -- show at a higher priority than lsp
                    },
                },
            },
        },
    },

    {
        "catppuccin",
        optional = true,
        opts = {
            integrations = { blink_cmp = true },
        },
    },
}
