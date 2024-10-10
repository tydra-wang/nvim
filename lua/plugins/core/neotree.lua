-- See https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/370#discussioncomment-8303412
local function copy_path(state)
    -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
    -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
    local node = state.tree:get_node()
    local filepath = node:get_id()
    local filename = node.name
    local modify = vim.fn.fnamemodify

    local results = {
        filepath,
        modify(filepath, ":."),
        modify(filepath, ":~"),
        filename,
        modify(filename, ":r"),
        modify(filename, ":e"),
    }

    vim.ui.select({
        "1. Absolute path: " .. results[1],
        "2. Path relative to CWD: " .. results[2],
        "3. Path relative to HOME: " .. results[3],
        "4. Filename: " .. results[4],
        "5. Filename without extension: " .. results[5],
        "6. Extension of the filename: " .. results[6],
    }, { prompt = "Choose to copy to clipboard:" }, function(choice)
        if choice then
            local i = tonumber(choice:sub(1, 1))
            if i then
                local result = results[i]
                vim.fn.setreg("+", result)
                vim.notify("Copied: " .. result)
            else
                vim.notify "Invalid selection"
            end
        else
            vim.notify "Selection cancelled"
        end
    end)
end

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    keys = {
        { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "toggle neotree" },
        { "<leader>B", "<cmd>Neotree float buffers<cr>", desc = "show buffers" },
    },
    cmd = "Neotree",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    opts = {
        window = {
            mappings = {
                ["<space>"] = "noop",
                ["s"] = "noop",
                ["S"] = "noop",
                ["z"] = "noop",
                ["Y"] = copy_path,
            },
        },
        sources = { "filesystem", "buffers", "git_status", "document_symbols" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
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
    config = function(_, opts)
        require("neo-tree").setup(opts)
        vim.api.nvim_create_autocmd("TermClose", {
            callback = function()
                if package.loaded["neo-tree.sources.git_status"] then
                    require("neo-tree.sources.git_status").refresh()
                end
            end,
        })
    end,
}
