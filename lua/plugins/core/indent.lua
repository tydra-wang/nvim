return {
    {
        "nmac427/guess-indent.nvim",
        event = "BufReadPre",
        config = true,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = { enabled = false },
        },
        ft = { "go", "lua", "c" },
        config = function(self, opts)
            require("ibl").setup(opts)
            -- only enable ibl for certain filetypes
            local hooks = require "ibl.hooks"
            hooks.register(hooks.type.ACTIVE, function(bufnr)
                return vim.tbl_contains(self.ft, vim.api.nvim_get_option_value("filetype", { buf = bufnr }))
            end)
        end,
    },
}
