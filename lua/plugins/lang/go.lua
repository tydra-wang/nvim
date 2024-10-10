local utils = require "plugins.utils"
local golangci_lint = require("null-ls").builtins.diagnostics.golangci_lint.with {
    cwd = require("null-ls.helpers").cache.by_bufnr(function(params)
        -- make issues less by using current dir instead of project root
        return vim.fs.dirname(params.bufname)
    end),
}
local gopls_settings = {
    semanticTokens = true,
}

if os.getenv "GOOS" == nil then
    if string.find(vim.fn.getcwd(), "csi") then
        -- https://github.com/golang/tools/blob/0734f6249fc1deb2d8b2724f0e0548474c39f884/gopls/doc/workspace.md#when-to-manually-configure-goos-goarch-or--tags
        gopls_settings.env = { GOOS = "linux" }
        -- require("lint").linters.golangcilint.env = {
        --     GOOS = "linux",
        -- }
        golangci_lint = golangci_lint.with { env = { GOOS = "linux" } }
    end
end

return {
    utils.telescope_ignore_pattern("go.sum", "vendor/.*", "/opt/homebrew/Cellar/go/.*"),
    utils.mason_ensure_install("gopls", "goimports", "gofumpt", "golangci-lint-langserver", "gomodifytags", "impl"),
    utils.setup_lspserver("gopls", {
        -- See https://github.com/golang/tools/blob/master/gopls/doc/daemon.md
        -- cmd = { "gopls", "-remote=auto" },
        settings = {
            gopls = gopls_settings,
        },
    }),
    utils.setup_formatters_by_ft("go", { "goimports" }),
    utils.enable_autoformat_for_ft("go", "gomod"),
    utils.add_null_ls_sources(golangci_lint, require("null-ls").builtins.code_actions.impl),

    -- utils.setup_linters_by_ft("go", { "golangcilint" }),
    -- utils.setup_linters_by_ft("gomod", { "golangcilint" }),
    -- utils.setup_lspserver("golangci_lint_ls", {}),

    {
        "ray-x/go.nvim",
        cond = false,
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
