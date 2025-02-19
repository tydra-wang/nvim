return {
    -- better quickfix
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        config = function()
            vim.cmd [[ packadd cfilter ]]
            require("bqf").setup {
                preview = {
                    auto_preview = false,
                },
            }
        end,
    },

    {
        "yorickpeterse/nvim-pqf",
        config = true,
        event = "VeryLazy",
    },
}
