local utils = require "plugins.utils"
local nls = require "null-ls"

return {
    utils.enable_indentline_for_filetype "lua",
    utils.mason_ensure_install("lua-language-server", "stylua"),
    utils.add_null_ls_sources(nls.builtins.formatting.stylua),

    utils.setup_lspserver("lua_ls", function()
        -- copy from lsp-zero nvim_workspace settings
        local runtime_path = vim.split(package.path, ";")
        table.insert(runtime_path, "lua/?.lua")
        table.insert(runtime_path, "lua/?/init.lua")
        return {
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
        }
    end),
}
