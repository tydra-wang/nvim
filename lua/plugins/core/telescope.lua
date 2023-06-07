local p = {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    opts = {
        defaults = {
            layout_config = {
                horizontal = {
                    preview_width = 0.55,
                    -- prompt_position = "top",
                },
            },
            sorting_strategy = "ascending",
            file_ignore_patterns = { "%.git/.*" },
        },
    },
    keys = {
        {
            "<leader>f",
            "<cmd>Telescope find_files previewer=false<cr>",
            desc = "find files",
        },
        {
            "<leader><leader>",
            "<cmd>Telescope oldfiles only_cwd=true previewer=false<cr>",
            desc = "find recent files",
        },
        {
            "<leader>b",
            "<cmd>Telescope buffers previewer=false<cr>",
            desc = "find buffers",
        },
        {
            "<leader>g",
            "<cmd>Telescope live_grep<cr>",
            desc = "grep word in whole project",
        },
        {
            "<leader>d",
            "<cmd>Telescope git_status<cr>",
            desc = "git status",
        },
    },
}

function p.config()
    local telescope = require "telescope"
    telescope.setup(p.opts)
    telescope.load_extension "fzf"
end

return p
