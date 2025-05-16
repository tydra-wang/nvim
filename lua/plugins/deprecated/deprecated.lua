return {

    { "karb94/neoscroll.nvim", event = "VeryLazy", config = true },

    {
        "numToStr/FTerm.nvim",
        config = true,
        cond = false,
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
}
