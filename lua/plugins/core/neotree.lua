return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    keys = {
        { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "toggle neotree" },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    opts = {
        -- open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
        filesystem = {
            follow_current_file = {
                enabled = true,
            },
            commands = {
                -- over write default 'delete' command to 'trash'.
                delete = function(state)
                    local inputs = require "neo-tree.ui.inputs"
                    local path = state.tree:get_node().path
                    local msg = "Are you sure you want to trash " .. path
                    inputs.confirm(msg, function(confirmed)
                        if not confirmed then
                            return
                        end

                        vim.fn.system { "trash", vim.fn.fnameescape(path) }
                        require("neo-tree.sources.manager").refresh(state.name)
                    end)
                end,

                -- over write default 'delete_visual' command to 'trash' x n.
                delete_visual = function(state, selected_nodes)
                    local inputs = require "neo-tree.ui.inputs"

                    -- get table items count
                    function GetTableLen(tbl)
                        local len = 0
                        for _ in pairs(tbl) do
                            len = len + 1
                        end
                        return len
                    end

                    local count = GetTableLen(selected_nodes)
                    local msg = "Are you sure you want to trash " .. count .. " files ?"
                    inputs.confirm(msg, function(confirmed)
                        if not confirmed then
                            return
                        end
                        for _, node in ipairs(selected_nodes) do
                            vim.fn.system { "trash", vim.fn.fnameescape(node.path) }
                        end
                        require("neo-tree.sources.manager").refresh(state.name)
                    end)
                end,
            },
        },
    },
}
