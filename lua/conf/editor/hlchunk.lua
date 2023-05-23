-- https://github.com/shellRaining/hlchunk.nvim

local M = {
    requires = {
        "hlchunk",
    },
}

function M.before() end

local whitespaceStyle = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui")

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
            textobject = "ic",
        },
        indent = {
            enable = true,
            -- use_treesitter = true,
            chars = {
                -- " ",
                "│",
                -- "¦",
                -- "┆",
                -- "┊",
            },
            -- style = {
            --     { bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui") },
            -- },
        },

        line_num = {
            enable = false,
        },

        blank = {
            enable = false,
            chars = {
                " ",
                -- "․",
                -- "⁚",
                -- "⁖",
                -- "⁘",
                -- "⁙",
            },
            style = {
                { bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("cursorline")), "bg", "gui") },
                { bg = "", fg = "" },
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
