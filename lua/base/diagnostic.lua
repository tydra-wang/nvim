local enabled_diagnostics = true
local function toggle_diagnostics()
    enabled_diagnostics = not enabled_diagnostics
    if enabled_diagnostics then
        vim.diagnostic.enable()
        vim.notify "Enabled diagnostics"
    else
        vim.diagnostic.disable()
        vim.notify "Disabled diagnostics"
    end
end

vim.api.nvim_create_user_command("DiagnosticsToggle", toggle_diagnostics, {})

vim.diagnostic.config {
    underline = true,
    update_in_insert = false,
    virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
    },
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
        },
    },
}
