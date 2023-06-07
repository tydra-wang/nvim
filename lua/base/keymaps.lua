vim.g.mapleader = " "

vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = ":w" })
vim.keymap.set("n", "<leader>n", "<C-6>", { desc = "last buffer" })
vim.keymap.set("n", "<ESC>", "<cmd>noh<cr>", { desc = ":noh" })

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "prev quickfix item" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "next quickfix item" })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

vim.keymap.set("i", "<C-a>", "<ESC>^i")
vim.keymap.set("i", "<C-e>", "<End>")
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")

vim.keymap.set("t", "<C-x>", "<C-\\><C-N>")
