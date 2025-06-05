vim.g.EditorConfig_exclude_patterns = "/opt/homebrew/Cellar/go"

local utils = require "plugins.utils"

vim.lsp.config("gopls", {
    settings = {
        gopls = {
            semanticTokens = true,
        },
    },
})

vim.lsp.enable "gopls"

return {
    utils.mason_ensure_install "gopls",
    utils.setup_formatters_by_ft("go", { "goimports" }),
    utils.enable_autoformat_for_ft("go", "gomod"),
    utils.setup_linters_by_ft("go", { "golangcilint" }),
}
