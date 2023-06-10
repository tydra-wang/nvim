-- format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local format_on_save = true
local toggle_format_on_save = function()
    format_on_save = not format_on_save
end

local nls_format = function(bufnr)
    vim.lsp.buf.format {
        bufnr = bufnr,
        sync = true,
        filter = function(client)
            return client.name == "null-ls"
        end,
    }
end

return {
    -- cmdline tools and lsp servers
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
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
            vim.api.nvim_create_user_command("LspFormat", function()
                nls_format()
            end, {})
            vim.api.nvim_create_user_command("LspFormatOnSaveToggle", function()
                toggle_format_on_save()
            end, {})
            vim.api.nvim_create_user_command("LspRename", function()
                vim.lsp.buf.rename()
            end, {})

            -- Global mappings
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set("n", "<leader>o", vim.diagnostic.open_float, { desc = "show diagnostic" })
            -- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "open diagnostics to qf" })

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
                    -- map("n", "gi", vim.lsp.buf.implementation, { desc = "lsp implementation" })
                    -- map("n", "gr", vim.lsp.buf.references, { desc = "lsp references" })
                    map("n", "K", vim.lsp.buf.hover, { desc = "lsp hover" })
                    map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "lsp code action" })
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
        event = { "BufReadPre", "BufNewFile" },
        dependencies = "williamboman/mason.nvim",
        opts = function()
            local nls = require "null-ls"
            return {
                sources = {
                    nls.builtins.diagnostics.codespell,
                },
                on_attach = function(client, bufnr)
                    if client.supports_method "textDocument/formatting" then
                        vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                if format_on_save then
                                    nls_format(bufnr)
                                end
                            end,
                        })
                    end
                end,
            }
        end,
    },

    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile" },
        opts = { delay = 200 },
        config = function(_, opts)
            require("illuminate").configure(opts)

            local function map(key, dir, buffer)
                vim.keymap.set("n", key, function()
                    require("illuminate")["goto_" .. dir .. "_reference"](false)
                end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
            end

            map("]]", "next")
            map("[[", "prev")

            -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    local buffer = vim.api.nvim_get_current_buf()
                    map("]]", "next", buffer)
                    map("[[", "prev", buffer)
                end,
            })
        end,
        keys = {
            { "]]", desc = "next reference" },
            { "[[", desc = "prev reference" },
        },
    },
}
