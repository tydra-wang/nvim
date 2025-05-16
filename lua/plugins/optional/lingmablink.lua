return {
    {
        url = "git@gitlab.alibaba-inc.com:kuafu-io/lingma.nvim.git",
        build = "./install.sh",
        lazy = false,
        dependencies = {
            "MunifTanjim/nui.nvim",
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
        lazy = false,
        dependencies = { "git@gitlab.alibaba-inc.com:kuafu-io/lingma.nvim.git" },
        opts = function(_, opts)
            table.insert(opts.sources, 1, {
                name = "Lingma",
                group_index = 1,
                priority = 100,
            })
        end,
    },
    {
        "saghen/blink.cmp",
        lazy = false,
        dependencies = { "git@gitlab.alibaba-inc.com:kuafu-io/lingma.nvim.git", "saghen/blink.compat" },
        opts = {
            sources = {
                default = { "lingma" },
                providers = {
                    lingma = {
                        score_offset = 100,
                        async = true,
                        name = "Lingma",
                        module = "blink.compat.source",
                    },
                },
            },
        },
    },
}
