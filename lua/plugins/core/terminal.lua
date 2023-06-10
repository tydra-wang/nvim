return {
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
}
