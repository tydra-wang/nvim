-- enable folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- without this, treesitter fold not work
vim.api.nvim_create_autocmd({ "BufEnter" }, { pattern = { "*" }, command = "normal zx" })

local p = {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
}

function p.config()
    require("nvim-treesitter.configs").setup {
        -- TODO: how to use textobjects
        textobjects = {
            enable = true,
        },
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
    }
end

return p
