return {
    -- cmdline tools and lsp servers
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall" },
        opts = {
            ensure_installed = {
                "codespell",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require "mason-registry"
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        print("Mason installing", tool)
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },

    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = "williamboman/mason.nvim",
        opts = {
            -- server settings
            servers = {
                -- lua_ls = {},
            },
        },
        config = function(_, opts)
            vim.api.nvim_create_user_command("LspRename", function()
                vim.lsp.buf.rename()
            end, {})

            -- Global mappings
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set("n", "<leader>o", vim.diagnostic.open_float, { desc = "show diagnostic" })
            vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "open diagnostics to qf" })

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded",
            })

            -- Buffer mappings
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    -- local client = vim.lsp.get_client_by_id(args.data.client_id)

                    -- setup mappings
                    local map = function(mode, lhs, rhs, map_opts)
                        map_opts.buffer = args.buffer
                        vim.keymap.set(mode, lhs, rhs, map_opts)
                    end
                    map("n", "gd", vim.lsp.buf.definition, { desc = "lsp definition" })
                    map("n", "gD", vim.lsp.buf.declaration, { desc = "lsp declaration" })
                    map("n", "gi", vim.lsp.buf.implementation, { desc = "lsp implementation" })
                    map("n", "gr", vim.lsp.buf.references, { desc = "lsp references" })
                    map("n", "K", vim.lsp.buf.hover, { desc = "lsp hover" })
                    map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "lsp code action" })
                    map("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "signature help" })
                end,
            })

            local capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
            )

            -- fix clangd conflict with null-ls
            -- see https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428#issuecomment-997234900
            capabilities.offsetEncoding = { "utf-16" }

            local servers = opts.servers
            for server in pairs(servers) do
                local server_opts = {
                    settings = servers[server],
                    capabilities = vim.deepcopy(capabilities),
                }
                require("lspconfig")[server].setup(server_opts)
            end
        end,
    },

    -- null-ls
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPost", "BufNewFile" },
        -- opts = function()
        --     local nls = require "null-ls"
        --     return {
        --         sources = {
        --             -- nls.builtins.diagnostics.codespell,
        --         },
        --     }
        -- end,
    },

    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            delay = 200,
            filetypes_denylist = {
                "NvimTree",
                "Trouble",
            },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)

            local function map(key, dir, buffer)
                vim.keymap.set("n", key, function()
                    require("illuminate")["goto_" .. dir .. "_reference"](false)
                end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
            end

            map("]r", "next")
            map("[r", "prev")

            -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    local buffer = vim.api.nvim_get_current_buf()
                    map("]r", "next", buffer)
                    map("[r", "prev", buffer)
                end,
            })
        end,
        keys = {
            { "]r", desc = "next reference" },
            { "[r", desc = "prev reference" },
        },
    },

    {
        "stevearc/conform.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function(_, opts)
            require("conform").setup(opts)
            local format_on_save = true
            local toggle_format_on_save = function()
                format_on_save = not format_on_save
            end
            local format_file = function(bufnr)
                require("conform").format {
                    bufnr = bufnr,
                    lsp_fallback = true,
                }
            end
            vim.api.nvim_create_user_command("Format", function()
                format_file()
            end, {})
            vim.api.nvim_create_user_command("FormatOnSaveToggle", function()
                toggle_format_on_save()
            end, {})
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    if format_on_save then
                        format_file(args.bufnr)
                    end
                end,
            })
        end,
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPost", "BufNewFile" },
        config = function(_, opts)
            local lint = require "lint"
            lint.linters_by_ft = opts.linters_by_ft or {}
            vim.api.nvim_create_autocmd({ "InsertLeave", "BufWrite", "BufRead" }, {
                group = vim.api.nvim_create_augroup("lint", { clear = true }),
                callback = function()
                    lint.try_lint()
                    lint.try_lint "codespell"
                end,
            })
        end,
    },
}
