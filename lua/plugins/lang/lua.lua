local utils = require "plugins.utils"

return {
    utils.mason_ensure_install("lua-language-server", "stylua"),
    utils.setup_formatters_by_ft("lua", { "stylua" }),

    utils.setup_lspserver("lua_ls", function()
        -- copy from lsp-zero nvim_workspace settings
        local runtime_path = vim.split(package.path, ";")
        table.insert(runtime_path, "lua/?.lua")
        table.insert(runtime_path, "lua/?/init.lua")
        return {
            settings = {
                Lua = {
                    -- Disable telemetry
                    telemetry = { enable = false },
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                        path = runtime_path,
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { "vim" },
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            -- Make the server aware of Neovim runtime files
                            vim.fn.expand "$VIMRUNTIME/lua",
                            vim.fn.stdpath "config" .. "/lua",
                        },
                    },
                },
            },
        }
    end),
}
