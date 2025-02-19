return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            -- dashboard = { enabled = true },
            indent = {
                enabled = true,
                filter = function(buf)
                    return vim.g.snacks_indent ~= false
                        and vim.b[buf].snacks_indent ~= false
                        and vim.bo[buf].buftype == ""
                end,
            },
            input = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            gitbrowse = { enabled = false },
        },
        -- stylua: ignore
        keys = {
            { "<leader>f", function() Snacks.picker.smart({filter = {cwd = true}, layout={preview = false}}) end, desc = "Smart find files" },
            { "<leader>/", function () Snacks.picker.grep({layout={preview=false}}) end, desc = "Find word" },
            { "<leader>Ff", function() Snacks.picker.files({layout={preview = false}}) end, desc = "Find files" },
            { "<leader>Fr", function () Snacks.picker.recent({filter = {cwd = true}, layout={preview = false}}) end, desc = "Find recent files" },
            { "<leader>Fs", function () Snacks.picker.lsp_symbols() end, desc = "Find lsp symbols" },

            { "<leader>Gg", function() Snacks.lazygit() end, desc = "Lazygit" },
            { "<leader>Gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
            { "<leader>GB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
            { "<leader>Gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
            { "<leader>Gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },

            { "<Leader>t", function() Snacks.terminal() end, desc = "Toggle Terminal" },

            { "]r", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
            { "[r", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
        },
    },
}
