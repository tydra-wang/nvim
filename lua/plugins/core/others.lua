return {
    { "folke/which-key.nvim", event = "VeryLazy" },

    {
        "echasnovski/mini.surround",
        config = true,
        keys = { "s" },
    },

    {
        "numToStr/Comment.nvim",
        config = true,
        keys = { "gc" },
    },

    {
        "phaazon/hop.nvim",
        branch = "v2",
        config = true,
        keys = { { "<leader>j", "<cmd>HopChar2<cr>", desc = "easy motion" } },
    },
}
