-- https://github.com/askfiy/visual_studio_code

local M = {
    requires = {
        "tokyonight",
    },
}

function M.before() end

function M.load()
    M.tokyonight.setup({
        transparent = true, -- Enable this to disable setting the background color
        styles = {
            sidebars = "transparent", -- style for sidebars, see below
            floats = "transparent", -- style for floating windows
        },
    })
    vim.cmd([[colorscheme tokyonight-moon]])
end

function M.after() end

return M
