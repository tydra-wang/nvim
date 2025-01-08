return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            -- dashboard = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
        keys = {
            {
                "<leader>Gg",
                function()
                    Snacks.lazygit()
                end,
                desc = "Lazygit",
            },
            {
                "<leader>Gb",
                function()
                    Snacks.git.blame_line()
                end,
                desc = "Git Blame Line",
            },
            {
                "<leader>GB",
                function()
                    Snacks.gitbrowse()
                end,
                desc = "Git Browse",
            },
            {
                "<leader>Gf",
                function()
                    Snacks.lazygit.log_file()
                end,
                desc = "Lazygit Current File History",
            },
            {
                "<leader>Gl",
                function()
                    Snacks.lazygit.log()
                end,
                desc = "Lazygit Log (cwd)",
            },
            {
                "<leader>cR",
                function()
                    Snacks.rename()
                end,
                desc = "Rename File",
            },
            {
                "<Leader>t",
                function()
                    Snacks.terminal()
                end,
                desc = "Toggle Terminal",
            },
            {
                "]r",
                function()
                    Snacks.words.jump(vim.v.count1)
                end,
                desc = "Next Reference",
                mode = { "n", "t" },
            },
            {
                "[r",
                function()
                    Snacks.words.jump(-vim.v.count1)
                end,
                desc = "Prev Reference",
                mode = { "n", "t" },
            },
            {
                "<leader>N",
                desc = "Neovim News",
                function()
                    Snacks.win {
                        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                        width = 0.6,
                        height = 0.6,
                        wo = {
                            spell = false,
                            wrap = false,
                            signcolumn = "yes",
                            statuscolumn = " ",
                            conceallevel = 3,
                        },
                    }
                end,
            },
        },
    },
}
