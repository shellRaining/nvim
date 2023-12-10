local M = {
    requires = { "tokyonight" },
}

function M.load()
    M.tokyonight.setup({
        transparent = false, -- Enable this to disable setting the background color
        styles = {
            sidebars = "transparent", -- style for sidebars, see below
            floats = "transparent", -- style for floating windows
        },
    })
    vim.cmd([[colorscheme tokyonight-moon]])
end

return M
