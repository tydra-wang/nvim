local M = {}

function M.mason_ensure_install(...)
    local packages = { ... }
    return {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, packages)
        end,
    }
end

---@param settings? table|function
function M.setup_lspserver(name, settings)
    local opts = {
        servers = {},
    }
    if type(settings) == "function" then
        opts.servers[name] = settings()
    else
        opts.servers[name] = settings
    end

    return {
        "neovim/nvim-lspconfig",
        opts = opts,
    }
end

function M.add_null_ls_sources(...)
    local sources = { ... }
    return {
        "jose-elias-alvarez/null-ls.nvim",
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            vim.list_extend(opts.sources, sources)
        end,
    }
end

function M.setup_formatters_by_ft(filetype, formatters)
    return {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                [filetype] = { formatters },
            },
        },
    }
end

function M.telescope_ignore_pattern(...)
    local patterns = { ... }
    return {
        "nvim-telescope/telescope.nvim",
        opts = function(_, opts)
            opts.defaults.file_ignore_patterns = opts.defaults.file_ignore_patterns or {}
            vim.list_extend(opts.defaults.file_ignore_patterns, patterns)
        end,
    }
end

return M
