local utils = require "plugins.utils"

vim.lsp.enable "lua_ls"

return {
    utils.mason_ensure_install("lua-language-server", "stylua"),
    utils.setup_formatters_by_ft("lua", { "stylua" }),
    utils.enable_autoformat_for_ft "lua",

    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "LazyVim", words = { "LazyVim" } },
                { path = "snacks.nvim", words = { "Snacks" } },
                { path = "lazy.nvim", words = { "LazyVim" } },
            },
        },
    },
}
