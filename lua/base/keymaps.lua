vim.g.mapleader = " "

vim.keymap.set("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "save buffer" })
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "escape and clear hlsearch" })
vim.keymap.set({ "n", "x" }, "gw", "*N", { desc = "search word under cursor" })
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "enter normal mode" })

-- switch between windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

-- switch between buffers
vim.keymap.set("n", "<leader>n", "<C-6>", { desc = "last buffer" })

-- switch between quickfix items
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "prev quickfix item" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "next quickfix item" })

-- switch between diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "next diagnostic" })

-- move cursor in insert mode
vim.keymap.set("i", "<C-a>", "<Home>")
vim.keymap.set("i", "<C-e>", "<End>")
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")

-- improve default behaviour of keys

-- better up/down
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
