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

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- show macro info
autocmd("RecordingEnter", {
    pattern = "*",
    callback = function()
        vim.opt.cmdheight = 1
    end,
})
autocmd("RecordingLeave", {
    pattern = "*",
    callback = function()
        vim.opt.cmdheight = 0
    end,
})

-- use q to close help/qf windows
autocmd("FileType", {
    pattern = {
        "qf",
        "help",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})
