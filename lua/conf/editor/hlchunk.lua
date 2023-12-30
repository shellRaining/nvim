-- https://github.com/shellRaining/hlchunk.nvim

local M = {
    requires = {
        "hlchunk",
        -- "hlchunk.mods.indent",
    },
    event = { "BufReadPre", "BufNewFile" },
}

function M.before() end

local cb = function()
    if vim.g.colors_name == "tokyonight" then
        return "#806d9c"
    else
        return "#00ffff"
    end
end

function M.load()
    M.hlchunk.setup({
        chunk = {
            enable = true,
            use_treesitter = true,
            notify = false,
            chars = {
                horizontal_line = "━",
                vertical_line = "┃",
                left_top = "┏",
                left_bottom = "┗",
                right_arrow = "━",
            },
            style = {
                { fg = cb },
                { fg = "#f35336" },
            },
            textobject = "ic",
        },

        indent = {
            enable = true,
            use_treesitter = false,
            notify = true,
            chars = {
                -- " ",
                -- "│",
                -- "¦",
                "┆",
                -- "┊",
            },
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
        -- context = {
        --     enable = false,
        -- },
    })
end

function M.after() end

return M
