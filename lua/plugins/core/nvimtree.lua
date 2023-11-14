vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "d", api.fs.trash, opts "Trash")
end

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
        on_attach = on_attach,
    },
}
