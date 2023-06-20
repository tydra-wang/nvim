return {
    {
        "nmac427/guess-indent.nvim",
        event = "BufReadPre",
        config = true,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function(_, opts)
            require("indent_blankline").setup(opts)
            -- https://github.com/lukas-reineke/indent-blankline.nvim/issues/449
            for _, keymap in pairs {
                "zo",
                "zO",
                "zc",
                "zC",
                "za",
                "zA",
                "zv",
                "zx",
                "zX",
                "zm",
                "zM",
                "zr",
                "zR",
            } do
                vim.api.nvim_set_keymap(
                    "n",
                    keymap,
                    keymap .. "<CMD>IndentBlanklineRefresh<CR>",
                    { noremap = true, silent = true }
                )
            end
        end,
    },
}
