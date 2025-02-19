-- see https://github.com/neovim/neovim/issues/5683
-- vim.cmd [[ language en_US.UTF-8 ]]

local opt = vim.opt
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.smartcase = true
opt.wrap = false
opt.signcolumn = "yes"
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.laststatus = 3 -- global statusline

opt.cmdheight = 0
-- See https://github.com/neovim/neovim/issues/20380#issuecomment-1435384187
-- opt.shortmess = "nocI"

-- See https://github.com/Homebrew/brew/issues/14007
-- workaround: echo "root = true" > /opt/homebrew/Cellar/.editorconfig
-- https://neovim.io/doc/user/editorconfig.html
-- vim.g.editorconfig = false
