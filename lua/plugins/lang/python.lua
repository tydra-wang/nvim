local utils = require "plugins.utils"

return {
    utils.mason_ensure_install("python-lsp-server", "black"),
    utils.setup_formatters_by_ft("python", { "black" }),

    utils.setup_lspserver("pylsp", {
        settings = {
            -- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
            pylsp = {
                plugins = {
                    pycodestyle = {
                        -- ignore = { "E302", "E305" },
                        enabled = false,
                        maxLineLength = 512,
                    },
                    -- pylint = {
                    --     enabled = false,
                    -- },
                },
            },
        },
    }),
}
