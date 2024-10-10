return {
    -- smooth scroll
    { "karb94/neoscroll.nvim", event = "VeryLazy", config = true },

    -- {
    --     "echasnovski/mini.animate",
    --     event = "VeryLazy",
    --     opts = function()
    --         local animate = require "mini.animate"
    --         local mouse_scrolled = false
    --         return {
    --             resize = {
    --                 timing = animate.gen_timing.linear { duration = 50, unit = "total" },
    --             },
    --             scroll = {
    --                 timing = animate.gen_timing.linear { duration = 150, unit = "total" },
    --                 subscroll = animate.gen_subscroll.equal {
    --                     predicate = function(total_scroll)
    --                         if mouse_scrolled then
    --                             mouse_scrolled = false
    --                             return false
    --                         end
    --                         return total_scroll > 1
    --                     end,
    --                 },
    --             },
    --         }
    --     end,
    -- },

    -- status line
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            {
                "linrongbin16/lsp-progress.nvim",
                config = true,
            },
        },
        opts = {
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = {
                    "filename",
                    "searchcount",
                    function()
                        -- invoke `progress` here.
                        return require("lsp-progress").progress()
                    end,
                },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            extensions = {
                -- "nvim-tree",
                "neo-tree",
                "quickfix",
                "man",
                "lazy",
                "symbols-outline",
                -- "trouble",
                "toggleterm",
            },
        },
        config = function(_, opts)
            require("lualine").setup(opts)
            -- listen lsp-progress event and refresh lualine
            vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
            vim.api.nvim_create_autocmd("User", {
                group = "lualine_augroup",
                pattern = "LspProgressStatusUpdated",
                callback = require("lualine").refresh,
            })
        end,
    },

    -- vscode-like winbar
    {
        "utilyre/barbecue.nvim",
        event = "VeryLazy",
        dependencies = {
            "SmiteshP/nvim-navic",
        },
        opts = {
            exclude_filetypes = { "gitcommit" },
        },
    },
}
