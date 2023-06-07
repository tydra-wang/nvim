vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
    "kyazdani42/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "toggle nvimtree" },
    },
    opts = {
        view = {
            width = 50,
        },
        trash = {
            cmd = "trash",
        },
        update_focused_file = {
            enable = true,
        },
    },
}
