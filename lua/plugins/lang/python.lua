local utils = require "plugins.utils"

return {
    utils.mason_ensure_install("python-lsp-server", "black"),
    utils.setup_formatters_by_ft("python", { "black" }),

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
