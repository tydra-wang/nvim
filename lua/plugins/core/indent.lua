return {
    {
        "nmac427/guess-indent.nvim",
        event = "BufReadPre",
        config = true,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        main = "ibl",
        opts = {
            scope = { enabled = false },
        },
    },
}
