local utils = require "plugins.utils"

vim.lsp.enable "neocmake"

return {
    -- utils.setup_linters_by_ft("cmake", { "cmakelint" }),
    utils.mason_ensure_install("neocmakelsp", "cmakelint"),
    {
        "Civitasv/cmake-tools.nvim",
        opts = {},
        ft = "cmake",
    },
}
