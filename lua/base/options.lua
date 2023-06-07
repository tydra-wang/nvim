-- see https://github.com/neovim/neovim/issues/5683
vim.cmd [[ language en_US.UTF-8 ]]

local opt = vim.opt
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.foldlevelstart = 99
opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.smartcase = true
opt.wrap = false
opt.signcolumn = "yes"
opt.clipboard = "unnamedplus"
opt.cmdheight = 0
opt.termguicolors = true
