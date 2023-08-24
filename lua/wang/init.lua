local M = {}

function M.setup(opts)
    if not opts then
        opts = {}
    end

    -- raw neovim settings
    require "base"

    -- install lazy.nvim
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

    -- core plugins
    local lazy_opts = {
        change_detection = {
            -- automatically check for config file changes and reload the ui
            enabled = false,
            notify = false, -- get a notification when changes are found
        },
        spec = {
            { import = "plugins.core" },
        },
    }

    -- local enabled plugins and extra plugins
    if opts and opts.spec then
        vim.list_extend(lazy_opts.spec, opts.spec)
    end

    require("lazy").setup(lazy_opts)

    local colorscheme = opts.colorscheme or "catppuccin"
    vim.cmd.colorscheme(colorscheme)
end

return M
