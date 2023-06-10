return {
    {
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
        opts = {
            integrations = {
                illuminate = true,
                mason = true,
                lsp_trouble = true,
                which_key = true,
            },
        },
    },

    -- {
    --     "utilyre/barbecue.nvim",
    --     opts = function(_, opts)
    --         opts.theme = "catppuccin"
    --     end,
    -- },
    --
    -- {
    --     "nvim-lualine/lualine.nvim",
    --     opts = function(_, opts)
    --         if not opts.options then
    --             opts.options = {}
    --         end
    --         opts.options.theme = "catppuccin"
    --     end,
    -- },
}
