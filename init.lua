vim.uv = vim.uv or vim.loop

-- raw neovim settings without any plugins
require "base"

-- install lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

-- load core plugins
local lazy_opts = {
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = false,
        -- get a notification when changes are found
        notify = false,
    },
    spec = {
        { import = "plugins.core" },
        -- default theme
        { import = "plugins.theme.catppuccin" },
    },
    ui = {
        border = "single",
    },
    git = {
        -- defaults for `Lazy log`
        -- log = { "-10" }, -- last 10 commits
        -- log = { "--since=1 days ago" }, -- commits from the last 3 days
        timeout = 1200, -- processes taking over 2 minutes will be killed
    },
}

local ok, rc = pcall(require, "rc")
rc = ok and rc or {}

if rc.spec then
    vim.list_extend(lazy_opts.spec, rc.spec)
end
require("lazy").setup(lazy_opts)

vim.cmd.colorscheme(rc.colorscheme or "catppuccin")
