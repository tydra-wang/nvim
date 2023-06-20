--  references:
--  https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

local augroup = vim.api.nvim_create_augroup("wang_base", { clear = true })
local autocmd = function(events, options)
    options.group = augroup
    vim.api.nvim_create_autocmd(events, options)
end

-- qf options
autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.opt.relativenumber = false
        vim.opt.cursorline = true
    end,
})

-- gitcommit options
autocmd("FileType", {
    pattern = "gitcommit",
    callback = function()
        vim.opt.relativenumber = false
        vim.opt.number = false
    end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    command = "checktime",
})

-- open a file from its last left off position
autocmd("BufReadPost", {
    callback = function()
        vim.cmd [[ if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
    end,
})

-- show macro info
autocmd("RecordingEnter", {
    callback = function()
        vim.opt.cmdheight = 1
    end,
})
autocmd("RecordingLeave", {
    callback = function()
        vim.opt.cmdheight = 0
    end,
})

-- use q to close help/qf windows
autocmd("FileType", {
    pattern = { "qf", "help" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})
