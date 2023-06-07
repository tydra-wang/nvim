local M = {}

function M.setup(opts)
    require "base"

    -- load plugins
    local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        }
    end
    vim.opt.rtp:prepend(lazypath)

    local lazy_opts = {
        change_detection = {
            -- automatically check for config file changes and reload the ui
            enabled = false,
            notify = false, -- get a notification when changes are found
        },
        spec = {
            { import = "plugins.core" },
            -- { import = "plugins.lang" },
        },
    }

    if opts and opts.spec then
        for _, spec in ipairs(opts.spec) do
            table.insert(lazy_opts.spec, spec)
        end
    end
    require("lazy").setup(lazy_opts)
    vim.cmd.colorscheme "catppuccin"
end

return M
