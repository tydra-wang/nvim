return {
    -- colorscheme
    {
        "navarasu/onedark.nvim",
        -- config = function()
        --     require("onedark").load()
        -- end,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            integrations = {
                illuminate = true,
                -- barbecue = true,
            },
        },
    },
    { "EdenEast/nightfox.nvim" },
    -- { "daschw/leaf.nvim" },

    -- indent
    {
        "nmac427/guess-indent.nvim",
        event = "BufReadPre",
        config = true,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            filetype = {},
        },
    },

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
    { "yorickpeterse/nvim-pqf", config = true },

    -- smooth scroll
    { "karb94/neoscroll.nvim", event = "VeryLazy", config = true },

    -- status line
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename", "searchcount" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            extensions = {
                "nvim-tree",
                "quickfix",
                "symbols-outline",
                "man",
                "lazy",
                "symbols-outline",
                "trouble",
                "toggleterm",
            },
        },
    },
    -- vscode-like winbar
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
        },
        opts = {
            theme = "catppuccin",
        },
        -- config = true,
        -- config = function()
        --     require("barbecue").setup {
        --         theme = "catppuccin",
        --     }
        -- end,
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
                "[d",
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
                "]d",
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
