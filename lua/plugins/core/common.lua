return {
    { "folke/which-key.nvim", event = "VeryLazy" },

    {
        "numToStr/Comment.nvim",
        config = true,
        keys = { "gc" },
    },

    {
        "echasnovski/mini.pairs",
        event = "InsertEnter",
        config = function(_, opts)
            require("mini.pairs").setup(opts)
        end,
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
