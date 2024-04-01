-- see https://github.com/neovim/neovim/issues/5683
vim.cmd [[ language en_US.UTF-8 ]]

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

-- https://github.com/neovim/neovim/issues/20380#issuecomment-1435384187
opt.cmdheight = 0
opt.shortmess = "nocI"

-- https://neovim.io/doc/user/editorconfig.html
-- disable editorconfig
vim.g.editorconfig = false
