return {
    {
        "nmac427/guess-indent.nvim",
        event = "BufReadPre",
        config = true,
        -- cond = false,
    },

    {
        "folke/which-key.nvim",
        -- event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "echasnovski/mini.icons",
        },
    },

    -- {
    --     "echasnovski/mini.pairs",
    --     config = true,
    --     event = "InsertEnter",
    -- },

    {
        {
            "echasnovski/mini.pairs",
            event = "VeryLazy",
            -- event = "InsertEnter", -- InsertEnter will not work
            opts = {
                modes = { insert = true, command = true, terminal = false },
                -- skip autopair when next character is one of these
                skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
                -- skip autopair when the cursor is inside these treesitter nodes
                skip_ts = { "string" },
                -- skip autopair when next character is closing pair
                -- and there are more closing pairs than opening pairs
                skip_unbalanced = true,
                -- better deal with markdown code blocks
                markdown = true,
            },
        },
    },
}
