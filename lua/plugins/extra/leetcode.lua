local leet_arg = "leetcode.nvim"

return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    lazy = leet_arg ~= vim.fn.argv()[1],
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim", -- required by telescope
        "MunifTanjim/nui.nvim",
        -- optional
        "nvim-tree/nvim-web-devicons",
        -- recommended
        -- "rcarriga/nvim-notify",
    },
    opts = {
        lang = "golang",
        arg = leet_arg,
        cn = { -- leetcode.cn
            enabled = true, ---@type boolean
            -- translate_problems = false, ---@type boolean
        },
    },
    -- config = function(_, opts)
    --     require("leetcode").setup(opts)
    -- end,
}
