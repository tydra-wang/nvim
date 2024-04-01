-- vim.opt.relativenumber = false

return {
    spec = {
        -- install all language plugins
        { import = "plugins.lang" },
        -- install specific language plugin
        -- { import = "plugins.lang.go" },

        -- install all themes
        { import = "plugins.theme" },
        -- install specific theme plugin
        -- { import = "plugins.theme.solarized" },

        { import = "plugins.extra.leetcode" },
        { import = "plugins.extra.noice" },

        -- custom plugins
        -- {
        --     "akinsho/bufferline.nvim",
        --     version = "*",
        --     dependencies = "nvim-tree/nvim-web-devicons",
        --     config = function()
        --         require("bufferline").setup {
        --             highlights = require("catppuccin.groups.integrations.bufferline").get(),
        --         }
        --     end,
        -- },
    },

    colorscheme = "tokyonight",
}
