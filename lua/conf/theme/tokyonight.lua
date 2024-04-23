local M = {
    requires = { "tokyonight" },
}

local config = vim.g.neovide and {
    transparent = false,
} or {
    transparent = true,
    styles = {
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
    },
}

function M.load()
    M.tokyonight.setup(config)
    vim.cmd([[colorscheme tokyonight-moon]])
end

return M
