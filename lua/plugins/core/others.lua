return {
    { "folke/which-key.nvim", event = "VeryLazy" },

    {
        "numToStr/Comment.nvim",
        config = true,
        keys = { "gc" },
    },

    {
        "numToStr/FTerm.nvim",
        config = true,
        keys = {
            {
                "<Leader>t",
                function()
                    require("FTerm").toggle()
                end,
                desc = "toggle float terminal",
            },
        },
    },

    {
        "phaazon/hop.nvim",
        branch = "v2",
        config = true,
        keys = { { "<leader>j", "<cmd>HopChar2<cr>", desc = "easy motion" } },
    },
}
