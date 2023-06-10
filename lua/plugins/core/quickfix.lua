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
        opts = { use_diagnostic_signs = true },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
            { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
            { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
            {
                "[t",
                function()
                    if require("trouble").is_open() then
                        require("trouble").previous { skip_groups = true, jump = true }
                    else
                        vim.diagnostic.goto_prev()
                    end
                end,
                desc = "Previous trouble/diagnostic item",
            },
            {
                "]t",
                function()
                    if require("trouble").is_open() then
                        require("trouble").next { skip_groups = true, jump = true }
                    else
                        vim.diagnostic.goto_next()
                    end
                end,
                desc = "Next trouble/diagnostic item",
            },
        },
    },
}
