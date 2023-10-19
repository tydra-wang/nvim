local utils = require "plugins.utils"

return {
    utils.mason_ensure_install "clangd",
    utils.setup_lspserver("clangd", {}),
    utils.setup_formatters_by_ft("c", { "clang_format" }),
}
