return {
    {
        url = "git@gitlab.alibaba-inc.com:kuafu-io/lingma.nvim.git",
        build = "./install.sh",
        lazy = false,
        dependencies = {
            "MunifTanjim/nui.nvim",
            -- "williamboman/nvim-lsp-installer",
            "neovim/nvim-lspconfig",
            "nvim-tree/nvim-web-devicons",
            "nvim-treesitter/nvim-treesitter",
            {
                "MeanderingProgrammer/render-markdown.nvim",
                ft = { "lingma_result" },
                config = function()
                    require("render-markdown").setup {
                        file_types = { "lingma_result" },
                    }
                end,
            },
        },
        config = function()
            require("lingma").setup {
                chat_trigger_key = "<leader>hh",
                contex_update_key = "<leader>uu",
                allow_statistics = true,
            }
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            table.insert(opts.sources, { name = "Lingma" })
        end,
        -- config = function()
        --     local cmp = require "cmp"
        --     cmp.setup {
        --         sources = {
        --             { name = "Lingma" },
        --         },
        --     }
        -- end,
    },
}
