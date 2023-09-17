-- https://github.com/neovim/nvim-lspconfig

local M = {
    requires = { "neodev" },
}

function M.load()
    M.neodev.setup()
end

return M
