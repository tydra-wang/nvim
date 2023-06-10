return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup {
                -- use default gitcommit highlight
                ignore_install = { "gitcommit" },
                -- automatically install missing parsers when entering buffer
                auto_install = true,
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            }

            -- enable folding
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
            -- without this, treesitter fold not work
            vim.api.nvim_create_autocmd({ "BufEnter" }, { pattern = { "*" }, command = "normal zx" })
        end,
    },
}
