return {
    -- smooth scroll
    { "karb94/neoscroll.nvim", event = "VeryLazy", config = true },

    -- status line
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename", "searchcount" },
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
