return {
    { "neovim/nvim-lspconfig" },

    -- cmdline tools and lsp servers
    {

        "williamboman/mason.nvim",
        event = "VeryLazy",
        build = ":MasonUpdate",
        opts_extend = { "ensure_installed" },
        opts = {
            ensure_installed = {
                "stylua",
                "shfmt",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require "mason-registry"
            mr.refresh(function()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end)
        end,
    },

    {
        "stevearc/conform.nvim",
        event = "VeryLazy",
        opts = {
            log_level = vim.log.levels.DEBUG,
            formatters_by_ft = {
                json = { "jq" },
            },
        },
        config = function(_, opts)
            opts.format_on_save = function(bufnr)
                -- Enable autoformat on certain filetypes
                local filetypes = opts.autoformat_filetypes or {}
                if not vim.tbl_contains(filetypes, vim.bo[bufnr].filetype) then
                    return
                end
                -- Disable with a global or buffer-local variable
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                -- Only enable autoformat for files under home
                -- local current_file_path = vim.fn.resolve(vim.fn.expand "%:p")
                -- local home = os.getenv "HOME"
                -- if not home or current_file_path:sub(1, #home) ~= home then
                --     return
                -- end
                return {
                    timeout_ms = 1000,
                    lsp_fallback = true,
                }
            end

            require("conform").setup(opts)
        end,
    },

    {
        "mfussenegger/nvim-lint",
        optional = true,
        event = "VeryLazy",
        config = function(_, opts)
            local lint = require "lint"
            lint.linters_by_ft = opts.linters_by_ft or {}
            --
            -- local codespell = lint.linters.codespell
            -- codespell.args = { "--config", vim.fn.stdpath "config" .. "/.codespellrc" }

            -- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "BufWritePost", "BufEnter" }, {
                group = vim.api.nvim_create_augroup("lint", { clear = true }),
                callback = function()
                    lint.try_lint()
                    lint.try_lint "codespell"
                end,
            })
        end,
    },

    {
        "nvimtools/none-ls.nvim",
        optional = true,
        -- dependencies = { "mason.nvim" },
        opts = {
            -- debug = true,
        },
        config = function(_, opts)
            opts = opts or {}
            opts.sources = opts.sources or {}
            local null_ls = require "null-ls"
            -- vim.list_extend(opts.sources, {
            --     null_ls.builtins.diagnostics.codespell.with {
            --         extra_args = { "--config", vim.fn.stdpath "config" .. "/.codespellrc" },
            --     },
            -- })
            null_ls.setup(opts)
        end,
    },
}
