local utils = require "plugins.utils"

vim.lsp.enable "dockerls"

return {
    utils.mason_ensure_install "dockerfile-language-server",
}
