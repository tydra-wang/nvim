local utils = require "plugins.utils"
-- local nls = require "null-ls"

return {
    utils.telescope_ignore_pattern("go.sum", "vendor/.*"),
    utils.mason_ensure_install("gopls", "goimports", "gofumpt", "golangci-lint-langserver", "gomodifytags", "impl"),
    utils.setup_lspserver("gopls", {}),
    -- utils.add_null_ls_sources(nls.builtins.code_actions.gomodifytags, nls.builtins.code_actions.impl),
    utils.setup_formatters_by_ft("go", { "goimports" }),
    utils.setup_linters_by_ft("go", { "golangcilint" }),

    {
        "ray-x/go.nvim",
        -- optional = true,
        ft = { "go", "gomod" },
        opts = { tag_transform = "camelcase" },
        dependencies = { "ray-x/guihua.lua" },
    },

    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/neotest-go",
        },
        opts = {
            adapters = {
                ["neotest-go"] = {
                    -- Here we can set options for neotest-go, e.g.
                    -- args = { "-tags=integration" }
                },
            },
        },
    },
}
