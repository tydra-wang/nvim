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
