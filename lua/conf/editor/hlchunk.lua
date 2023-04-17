-- https://github.com/shellRaining/hlchunk.nvim

local M = {
    requires = {
        "hlchunk",
    },
}

function M.before() end

function M.load()
    M.hlchunk.setup({
        chunk = {
            enable = false,
            chars = {
                horizontal_line = "─",
                vertical_line = "│",
                left_top = "┌",
                left_bottom = "└",
                right_arrow = "─",
            },
            style = "#00ffff",
        },
        indent = {
            enable = true,
        },

        line_num = {
            enable = false,
        },
        --
        blank = {
            enable = true,
        },
        context = {
            enable = false,
        },
    })
end

function M.after() end

return M
