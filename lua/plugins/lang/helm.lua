vim.filetype.add {
    pattern = {
        [".*/templates/.*%.yaml"] = "helm",
        [".*/templates/.*%.tpl"] = "helm",
    },
}

-- treesitter for highlights

return {}
