vim.g.EditorConfig_exclude_patterns = "/opt/homebrew/Cellar/go"

local utils = require "plugins.utils"

vim.lsp.config("gopls", {
    settings = {
        gopls = {
            -- gofumpt = true,
            staticcheck = true,
            semanticTokens = true,
        },
    },
})

vim.lsp.enable "gopls"

return {
    utils.mason_ensure_install "gopls",
    utils.setup_formatters_by_ft("go", { "goimports" }),
    -- utils.setup_formatters_by_ft("go", { "goimports", "gofumpt" }),
    utils.enable_autoformat_for_ft("go", "gomod"),
    -- utils.setup_linters_by_ft("go", { "golangcilint" }),
    --
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            { "fredrikaverpil/neotest-golang", version = "*" }, -- Installation
        },
        config = function()
            local neotest_golang_opts = {} -- Specify custom configuration
            require("neotest").setup {
                adapters = {
                    require "neotest-golang"(neotest_golang_opts), -- Registration
                },
            }
        end,
        -- stylua: ignore
        keys = {
            { "<leader>T", "", desc = "+test"},
            { "<leader>Tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
            { "<leader>TT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
            { "<leader>Tr", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
            { "<leader>Tl", function() require("neotest").run.run_last() end, desc = "Run Last (Neotest)" },
            { "<leader>Ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
            { "<leader>To", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
            { "<leader>TO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
            { "<leader>TS", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
            { "<leader>Tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch (Neotest)" },
        },
    },
}

--[[
-- directly using goimports is better

                    -- organizeImports
                    -- See https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports-and-formatting
                    local params = {
                        context = { only = { "source.organizeImports" } },
                        textDocument = vim.lsp.util.make_text_document_params(args.buf),
                    }
                    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
                    for cid, res in pairs(result or {}) do
                        for _, r in pairs(res.result or {}) do
                            if r.edit then
                                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                                vim.lsp.util.apply_workspace_edit(r.edit, enc)
                            end
                        end
                    end
    --]]
