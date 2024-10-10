return {
    {
        "nmac427/guess-indent.nvim",
        event = "BufReadPre",
        config = true,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        -- event = "VeryLazy",
        main = "ibl",
        opts = {
            indent = {
                char = "│",
                tab_char = "│",
            },
            scope = { enabled = false },
        },
        ft = { "go", "lua", "c" },
        cmd = { "IBLToggleBuf" },
        init = function()
            vim.api.nvim_create_user_command("IBLToggleBuf", function()
                vim.b.ibl_enable = not vim.b.ibl_enable
            end, {})
        end,
        config = function(self, opts)
            require("ibl").setup(opts)
            -- only enable ibl for certain filetypes
            local hooks = require "ibl.hooks"
            hooks.register(hooks.type.ACTIVE, function(bufnr)
                return vim.tbl_contains(self.ft, vim.api.nvim_get_option_value("filetype", { buf = bufnr }))
                    or vim.b.ibl_enable
            end)
        end,
    },
}
