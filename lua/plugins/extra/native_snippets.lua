return {
    desc = "Use native snippets instead of LuaSnip. Only works on Neovim >= 0.10!",
    {
        "L3MON4D3/LuaSnip",
        enabled = vim.fn.has "nvim-0.10.0" == 0,
    },
    {
        "nvim-cmp",
        enabled = vim.fn.has "nvim-0.10.0" == 1,
        opts = {
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },
        },
        keys = {
            {
                "<Tab>",
                function()
                    if vim.snippet.jumpable(1) then
                        vim.schedule(function()
                            vim.snippet.jump(1)
                        end)
                        return
                    end
                    return "<Tab>"
                end,
                expr = true,
                silent = true,
                mode = "i",
            },
            {
                "<Tab>",
                function()
                    vim.schedule(function()
                        vim.snippet.jump(1)
                    end)
                end,
                silent = true,
                mode = "s",
            },
            {
                "<S-Tab>",
                function()
                    if vim.snippet.jumpable(-1) then
                        vim.schedule(function()
                            vim.snippet.jump(-1)
                        end)
                        return
                    end
                    return "<S-Tab>"
                end,
                expr = true,
                silent = true,
                mode = { "i", "s" },
            },
        },
    },
}
