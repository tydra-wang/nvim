return {
    {
        "nmac427/guess-indent.nvim",
        event = "BufReadPre",
        config = true,
        -- cond = false,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "echasnovski/mini.icons",
        },
    },

    {
        "echasnovski/mini.pairs",
        config = true,
        event = "InsertEnter",
    },

    -- {
    --     "numToStr/Comment.nvim",
    --     config = true,
    --     keys = { "gc" },
    -- },
}
