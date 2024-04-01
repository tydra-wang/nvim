return {
    -- cmdline tools and lsp servers
    {
        "williamboman/mason.nvim",
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
        event = "VeryLazy",
        dependencies = "williamboman/mason.nvim",
        opts = {
            -- server settings
            servers = {
                -- lua_ls = {},
            },
        },
        config = function(_, opts)
            -- custom commands
            vim.api.nvim_create_user_command("LspRename", function()
                vim.lsp.buf.rename()
            end, {})

            -- Global mappings
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set("n", "<leader>o", vim.diagnostic.open_float, { desc = "show diagnostic" })
            vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "open diagnostics to qf" })

            -- signature help with border
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded",
            })
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = "rounded",
            })

            -- this function is generated by gpt
            local function quickfix_to_location(quickfix_item)
                -- Convert the file path to a URI
                local uri = vim.uri_from_fname(quickfix_item.filename)
                -- The `line` and `col` in quickfix are 1-based, but LSP expects 0-based indexes
                local line = quickfix_item.lnum - 1
                local character = quickfix_item.col - 1
                -- Create the Location object
                local location = {
                    uri = uri,
                    range = {
                        start = { line = line, character = character },
                        ["end"] = { line = line, character = character },
                    },
                }
                return location
            end

            -- Buffer mappings
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    -- See :h lsp-on-list-handler
                    -- use 'copen' instead of 'botright copen'
                    local function on_list(options)
                        -- See https://github.com/neovim/neovim/blob/11e8e14628413e45e46d2d2a7af53d0da0c9dcdd/runtime/lua/vim/lsp/handlers.lua#L440
                        if client and #options.items == 1 then
                            require("vim.lsp.util").jump_to_location(
                                quickfix_to_location(options.items[1]),
                                client.offset_encoding
                            )
                        else
                            vim.fn.setqflist({}, " ", options)
                            vim.cmd "cclose"
                            vim.cmd "lclose"
                            vim.cmd "copen"
                        end
                    end

                    -- setup mappings
                    local map = function(mode, lhs, rhs, map_opts)
                        map_opts.buffer = args.buffer
                        vim.keymap.set(mode, lhs, rhs, map_opts)
                    end

                    map("n", "gi", function()
                        vim.lsp.buf.implementation { on_list = on_list }
                    end, { desc = "lsp implementation" })

                    map("n", "gr", function()
                        vim.lsp.buf.references(nil, { on_list = on_list })
                    end, { desc = "lsp references" })

                    -- map("n", "gD", vim.lsp.buf.declaration, { desc = "lsp declaration" })
                    map("n", "gd", function()
                        vim.lsp.buf.definition { on_list = on_list }
                    end, { desc = "lsp definition" })
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

            for server, server_opts in pairs(opts.servers) do
                server_opts.capabilities = capabilities
                require("lspconfig")[server].setup(server_opts)
            end
        end,
    },

    {
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        opts = {
            delay = 200,
            filetypes_denylist = { "NvimTree", "Trouble", "qf", "neo-tree" },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)
            local function map(key, dir)
                vim.keymap.set("n", key, function()
                    require("illuminate")["goto_" .. dir .. "_reference"](false)
                end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference" })
            end
            map("]r", "next")
            map("[r", "prev")
        end,
        keys = {
            { "]r", desc = "next reference" },
            { "[r", desc = "prev reference" },
        },
    },

    {
        "stevearc/conform.nvim",
        event = "VeryLazy",
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
        event = "VeryLazy",
        config = function(_, opts)
            local lint = require "lint"
            lint.linters_by_ft = opts.linters_by_ft or {}
            local codespell = lint.linters.codespell
            codespell.args = { "--config", vim.fn.stdpath "config" .. "/.codespellrc" }
            vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "BufWritePost", "BufEnter" }, {
                group = vim.api.nvim_create_augroup("lint", { clear = true }),
                callback = function()
                    lint.try_lint()
                    lint.try_lint "codespell"
                end,
            })
        end,
    },
}
