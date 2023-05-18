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
            enable = true,
            use_treesitter = true,
            chars = {
                horizontal_line = "─",
                vertical_line = "│",
                left_top = "┌",
                left_bottom = "└",
                right_arrow = "─",
            },
            -- style = "#00ffff",
        },
        indent = {
            enable = true,
            -- use_treesitter = true,
            chars = {
                "│",
                -- "¦",
                -- "┆",
                -- "┊",
            },
        },

        line_num = {
            enable = false,
        },

        blank = {
            enable = false,
            chars = {
                "․",
                -- "⁚",
                -- "⁖",
                -- "⁘",
                -- "⁙",
            },
            -- style = {
            --     "#FF0000",
            --     "#FF7F00",
            --     "#FFFF00",
            --     "#00FF00",
            --     "#00FFFF",
            --     "#0000FF",
            --     "#8B00FF",
            -- },
        },
        context = {
            enable = false,
        },
    })
end

function M.after() end

return M
