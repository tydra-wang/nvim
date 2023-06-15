local p = {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        -- {
        --     "ahmedkhalf/project.nvim",
        --     opts = {
        --         patterns = { ".git" },
        --     },
        --     event = "VeryLazy",
        --     config = function(_, opts)
        --         require("project_nvim").setup(opts)
        --         require("telescope").load_extension "projects"
        --     end,
        --     keys = {
        --         { "<leader>p", "<Cmd>Telescope projects<CR>", desc = "find projects" },
        --     },
        -- },
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
            "<cmd>Telescope lsp_document_symbols symbol_width=60<cr>",
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
    },
}

function p.config()
    local telescope = require "telescope"
    telescope.setup(p.opts)
    telescope.load_extension "fzf"
end

return p
