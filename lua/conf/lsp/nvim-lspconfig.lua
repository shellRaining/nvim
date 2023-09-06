-- https://github.com/neovim/nvim-lspconfig

local join = require("utils.api").path.join
local options = require("core.options")

local M = {
    requires = {
        "lspconfig",
        "mason-lspconfig",
    },
    server_config_path = join("conf", "lsp", "server_configurations"),
}

function M.load()
end

return M
