-- https://github.com/neovim/nvim-lspconfig

local M = {
    requires = { "neodev" },
    ft = { "lua" },
}

function M.load()
    M.neodev.setup()
end

return M
