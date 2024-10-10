--  references:
--  https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

local augroup = vim.api.nvim_create_augroup("tydra-wang", { clear = true })
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
autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd "checktime"
        end
    end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
            return
        end
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
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

-- close some filetypes with <q>
autocmd("FileType", {
    pattern = {
        "help",
        "qf",
        "checkhealth",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- TODO: still too slow on large files

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
-- mini.animate will also be disabled.
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

vim.filetype.add {
    pattern = {
        [".*"] = {
            function(path, buf)
                return vim.bo[buf]
                        and vim.bo[buf].filetype ~= "bigfile"
                        and path
                        and vim.fn.getfsize(path) > vim.g.bigfile_size
                        and "bigfile"
                    or nil
            end,
        },
    },
}

autocmd({ "FileType" }, {
    pattern = "bigfile",
    callback = function(ev)
        vim.b.minianimate_disable = true
        vim.schedule(function()
            vim.bo[ev.buf].syntax = vim.filetype.match { buf = ev.buf } or ""
        end)
    end,
})
