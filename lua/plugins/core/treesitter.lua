return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        -- enabled = false,
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
            auto_install = true,
            -- ensure_installed = {
            --     "vim",
            --     "gitcommit",
            --     "diff",
            -- },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
            -- -- enable folding
            -- vim.opt.foldmethod = "expr"
            -- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
            -- -- without this, treesitter fold not work
            -- vim.api.nvim_create_autocmd({ "BufEnter" }, { pattern = { "*" }, command = "normal zx" })
        end,
    },
}
