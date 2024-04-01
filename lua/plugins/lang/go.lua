local utils = require "plugins.utils"
-- local nls = require "null-ls"
-- vim.fn.setenv("GOOS", "linux")

return {
    utils.telescope_ignore_pattern("go.sum", "vendor/.*", "/opt/homebrew/Cellar/go/.*"),
    utils.mason_ensure_install("gopls", "goimports", "gofumpt", "golangci-lint-langserver", "gomodifytags", "impl"),
    utils.setup_lspserver("gopls", {
        -- See https://github.com/golang/tools/blob/master/gopls/doc/daemon.md
        -- cmd = { "gopls", "-remote=auto" },
    }),
    -- utils.add_null_ls_sources(nls.builtins.code_actions.gomodifytags, nls.builtins.code_actions.impl),
    utils.setup_formatters_by_ft("go", { "goimports" }),

    utils.setup_linters_by_ft("go", { "golangcilint" }),
    -- utils.setup_lspserver("golangci_lint_ls", {}),

    {
        "ray-x/go.nvim",
        -- optional = true,
        ft = { "go", "gomod" },
        opts = {
            tag_transform = "camelcase",
            diagnostic = false, -- avoid conflict with custom diagnostic config
            -- max_line_len = 256,
        },
        dependencies = { "ray-x/guihua.lua" },
    },

    {
        "nvim-neotest/neotest",
        enabled = false,
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
