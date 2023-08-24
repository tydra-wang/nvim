local utils = require "plugins.utils"

return {
    utils.mason_ensure_install "dockerfile-language-server",
    utils.setup_lspserver("dockerls", {}),
}
