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

local function next_issue()
    local loclist_open = vim.fn.getloclist(0, { winid = 0 }).winid ~= 0
    if loclist_open then
        vim.cmd.lnext()
    else
        vim.cmd.cnext()
    end
end

local function prev_issue()
    local loclist_open = vim.fn.getloclist(0, { winid = 0 }).winid ~= 0
    if loclist_open then
        vim.cmd.lprev()
    else
        vim.cmd.cprev()
    end
end

vim.keymap.set("n", "]q", next_issue, { noremap = true, silent = true, desc = "next locallist/quickfix item" })
vim.keymap.set("n", "[q", prev_issue, { noremap = true, silent = true, desc = "prev locallist/quickfix item" })

-- switch between diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "next diagnostic" })

-- move cursor in insert mode
vim.keymap.set("i", "<C-a>", "<ESC>^i")
vim.keymap.set("i", "<C-e>", "<End>")
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
-- vim.keymap.set("i", "<C-j>", "<Down>")
-- vim.keymap.set("i", "<C-k>", "<Up>")

-- improve default behaviour of keys

-- better up/down
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- use register _ in some cases
vim.keymap.set("n", "c", '"_c', { noremap = true })
vim.keymap.set("x", "c", '"_c', { noremap = true })
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text
vim.keymap.set("x", "p", '"_dP', { noremap = true })

-- add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
