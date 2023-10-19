require("wang").setup {
    -- add lazy.nvim plugin specs
    spec = {
        -- use "ls -l lua/plugins/lang" to see all supported languages
        -- install all language plugins
        -- { import = "plugins.lang" },
        -- install only golang plugins
        -- { import = "plugins.lang.go" },

        -- use "ls -l lua/plugins/theme" to see all supported themes
        -- install all themes
        -- { import = "plugins.theme" },

        -- add extra plugins
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

    -- colorscheme = "tokyonight",
}

-- overwrite some options
-- vim.opt.relativenumber = false
