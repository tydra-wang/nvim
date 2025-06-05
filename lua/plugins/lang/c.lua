local utils = require "plugins.utils"

vim.lsp.enable "clangd"

return {
    utils.mason_ensure_install "clangd",
    -- utils.setup_formatters_by_ft("c", { "clang_format" }),
}
