local utils = require "plugins.utils"
local nls = require "null-ls"

return {
    utils.enable_indentline_for_filetype "go",
    utils.telescope_ignore_pattern("go.sum", "vendor/.*"),

    utils.mason_ensure_install("gopls", "goimports", "gofumpt", "golangci-lint-langserver", "gomodifytags", "impl"),

    utils.setup_lspserver("gopls", {}),
    -- utils.setup_lspserver("golangci_lint_ls", {}),

    utils.add_null_ls_sources(
        -- nls.builtins.code_actions.gomodifytags,
        -- nls.builtins.code_actions.impl,
        -- nls.builtins.formatting.gofumpt,
        nls.builtins.diagnostics.golangci_lint,
        nls.builtins.formatting.goimports
    ),

    {
        "ray-x/go.nvim",
        ft = { "go", "gomod" },
        opts = { tag_transform = "camelcase" },
        dependencies = { "ray-x/guihua.lua" },
    },
}
