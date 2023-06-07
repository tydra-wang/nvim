local autocmd = vim.api.nvim_create_autocmd
local opt = vim.opt

-- qf options
autocmd("FileType", {
    pattern = "qf",
    callback = function()
        opt.relativenumber = false
        opt.cursorline = true
    end,
})

-- git commit
autocmd("FileType", {
    pattern = "gitcommit",
    callback = function()
        opt.relativenumber = false
        opt.number = false
    end,
})

-- open a file from its last left off position
autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        vim.cmd [[ if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
    end,
})

-- show macro info
autocmd("RecordingEnter", {
    pattern = "*",
    callback = function()
        opt.cmdheight = 1
    end,
})
autocmd("RecordingLeave", {
    pattern = "*",
    callback = function()
        opt.cmdheight = 0
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
