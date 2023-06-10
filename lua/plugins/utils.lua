local M = {}

function M.enable_indentline_for_filetype(ft)
    return {
        "lukas-reineke/indent-blankline.nvim",
        opts = function(_, opts)
            if opts.filetype == nil then
                opts.filetype = { ft }
            else
                table.insert(opts.filetype, ft)
            end
        end,
    }
end

function M.mason_ensure_install(...)
    local packages = { ... }
    return {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            for _, v in ipairs(packages) do
                table.insert(opts.ensure_installed, v)
            end
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
            for _, source in ipairs(sources) do
                table.insert(opts.sources, source)
            end
        end,
    }
end

function M.telescope_ignore_pattern(...)
    local patterns = { ... }
    return {
        "nvim-telescope/telescope.nvim",
        opts = function(_, opts)
            for _, pattern in ipairs(patterns) do
                table.insert(opts.defaults.file_ignore_patterns, pattern)
            end
        end,
    }
end

return M
