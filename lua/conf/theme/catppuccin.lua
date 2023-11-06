local M = {
    requires = { "catppuccin" },
}

function M.load()
    M.catppuccin.setup({
        transparent_background = true,
    })
    -- vim.cmd.colorscheme "catppuccin"
end

return M
