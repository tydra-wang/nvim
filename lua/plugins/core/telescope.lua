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
            preview = false,
            sorting_strategy = "ascending",
            file_ignore_patterns = { "%.git/.*" },
        },
    },
    keys = {
        {
            "<leader>f",
            "<cmd>Telescope find_files<cr>",
            desc = "find files",
        },
        {
            "<leader>s",
            "<cmd>Telescope lsp_document_symbols<cr>",
            desc = "find symbols in buffer",
        },
        {
            "<leader><leader>",
            "<cmd>Telescope oldfiles only_cwd=true<cr>",
            desc = "find recent files",
        },
        {
            "<leader>b",
            "<cmd>Telescope buffers<cr>",
            desc = "find buffers",
        },
        {
            "<leader>g",
            "<cmd>Telescope live_grep preview=true<cr>",
            desc = "grep word in whole project",
        },
        {
            "<leader>d",
            "<cmd>Telescope git_status preview=true<cr>",
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
