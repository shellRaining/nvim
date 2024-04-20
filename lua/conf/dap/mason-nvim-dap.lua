local M = {
    requires = {
        "mason-nvim-dap",
    },
    cmd = { "DapInstall", "DapUninstall" },
}

function M.load()
    M.mason_nvim_dap.setup({
        ensure_installed = { "js" },
        handlers = {}, -- sets up dap in the predefined manner
    })
end

return M
