-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md

---@diagnostic disable: param-type-mismatch

local options = require("core.options")

local M = {
    requires = {
        "mason",
        "mason-registry",
    },
}

function M.before()
end

function M.load()
    M.mason.setup({
        max_concurrent_installers = 20,
        ui = {
            border = options.float_border and "double" or "none",
        },
        install_root_dir = options.mason_install_directory,
    })
end

function M.after()
end

return M
