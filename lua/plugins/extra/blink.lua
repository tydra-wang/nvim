return {
    {
        "hrsh7th/nvim-cmp",
        optional = true,
        enabled = false,
    },
    {
        "saghen/blink.cmp",
        version = "*",
        -- build = "cargo build --release",
        opts_extend = {
            "sources.completion.enabled_providers",
            -- "sources.compat",
            "sources.default",
        },
        dependencies = {
            "rafamadriz/friendly-snippets",
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
                use_nvim_cmp_as_default = false,
                -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono",
            },
            completion = {
                accept = {
                    -- experimental auto-brackets support
                    auto_brackets = {
                        enabled = true,
                    },
                },
                menu = {
                    draw = { treesitter = { "lsp" } },
                    border = "single",
                },
                documentation = {
                    window = { border = "single" },
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                -- ghost_text = {
                --     enabled = vim.g.ai_cmp,
                -- },
            },

            -- experimental signature help support
            signature = {
                -- enabled = true,
                window = { border = "single" },
            },

            sources = {
                -- adding any nvim-cmp sources here will enable them
                -- with blink.compat
                -- compat = {},
                default = { "lsp", "path", "snippets", "buffer" },
                cmdline = {}, -- disable cmdline
            },

            keymap = {
                preset = "enter",
                -- preset = "super-tab",
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
