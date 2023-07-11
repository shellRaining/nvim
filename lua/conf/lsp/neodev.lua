-- https://github.com/neovim/nvim-lspconfig

local M = {
    requires = {
        "neodev", -- neovim lua api complete enhance, must require
    },
}

function M.load()
    M.neodev.setup()
end

return M
