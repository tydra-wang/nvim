local utils = require "plugins.utils"

return {
    utils.setup_linters_by_ft("cmake", { "cmakelint" }),
    utils.mason_ensure_install("neocmakelsp", "cmakelint"),
    utils.setup_lspserver("neocmake", {}),
    {
        "Civitasv/cmake-tools.nvim",
        opts = {},
        ft = "cmake",
    },
}
