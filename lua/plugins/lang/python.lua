local utils = require "plugins.utils"
local nls = require "null-ls"

return {
    utils.mason_ensure_install("python-lsp-server", "black"),
    utils.add_null_ls_sources(nls.builtins.formatting.black),

    utils.setup_lspserver("pylsp", {
        -- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
        pylsp = {
            plugins = {
                pycodestyle = {
                    maxLineLength = 100,
                },
            },
        },
    }),
}
