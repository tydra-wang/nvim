local utils = require "plugins.utils"
local nls = require "null-ls"

return {
    utils.mason_ensure_install "clangd",
    utils.setup_lspserver("clangd", {}),
    utils.add_null_ls_sources(nls.builtins.formatting.clang_format),
}
