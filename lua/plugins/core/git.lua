return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "Gitsigns" },
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "next change(git hunk)" })

                map("n", "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "prev change(git hunk)" })

                -- Actions
                map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "stage hunk" })
                map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "reset hunk" })
                map("n", "<leader>hS", gs.stage_buffer, { desc = "stage buffer" })
                map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
                map("n", "<leader>hR", gs.reset_buffer, { desc = "undo stage buffer" })
                map("n", "<leader>hp", gs.preview_hunk, { desc = "preview hunk" })
                -- map("n", "<leader>hb", function()
                --     gs.blame_line { full = true }
                -- end)
                -- map("n", "<leader>tb", gs.toggle_current_line_blame)
                -- map("n", "<leader>hd", gs.diffthis)
                -- map("n", "<leader>hD", function()
                --     gs.diffthis "~"
                -- end)
                -- map("n", "<leader>td", gs.toggle_deleted)

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select hunk" })
            end,
        },
    },

    {
        "ruifm/gitlinker.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true,
        opts = {
            mappings = "<leader>y",
            callbacks = {
                ["gitlab.alibaba-inc.com"] = function(url_data)
                    local url = "https://code.alibaba-inc.com/"
                        .. url_data.repo
                        .. "/blob/"
                        .. url_data.rev
                        .. "/"
                        .. url_data.file
                    if url_data.lstart then
                        url = url .. "#L" .. url_data.lstart
                        if url_data.lend then
                            url = url .. "-L" .. url_data.lend
                        end
                    end
                    return url
                end,
            },
        },
        keys = {
            { "<leader>y", desc = "copy git link" },
        },
    },

    -- { "akinsho/git-conflict.nvim", version = "*", config = true },

    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen" },
    },

    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "sindrets/diffview.nvim",
        },
        cmd = { "Neogit" },
        config = true,
    },
}
