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
        ft = { "qf" },
    },

    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = {
            padding = false,
            use_diagnostic_signs = true,
            -- auto_preview = false,
        },
        keys = {
            -- { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
            -- { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
            -- { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
            -- { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
            {
                "<leader>q",
                "<cmd>Trouble document_diagnostics<cr>",
                desc = "open document diagnostics",
            },
            {
                "gr",
                "<cmd>Trouble lsp_references<cr>",
                desc = "goto lsp references",
            },
            {
                "gi",
                "<cmd>Trouble lsp_implementations<cr>",
                desc = "goto lsp implementation",
            },
            {
                "[q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").previous { skip_groups = true, jump = true }
                    else
                        local ok, err = pcall(vim.cmd.cprev)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "previous Trouble/quickfix item",
            },
            {
                "]q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").next { skip_groups = true, jump = true }
                    else
                        local ok, err = pcall(vim.cmd.cnext)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "next Trouble/quickfix item",
            },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("wang_trouble.nvim", { clear = true }),
                pattern = { "Trouble" },
                callback = function(event)
                    vim.opt_local.cursorline = true
                    vim.keymap.set("n", "<c-n>", function()
                        require("trouble").next { skip_groups = true, jump = false }
                    end, { buffer = event.buf, silent = true })
                    vim.keymap.set("n", "<c-p>", function()
                        require("trouble").previous { skip_groups = true, jump = false }
                    end, { buffer = event.buf, silent = true })
                end,
            })
        end,
    },
}
