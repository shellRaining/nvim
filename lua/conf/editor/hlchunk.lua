-- https://github.com/shellRaining/hlchunk.nvim

local M = {
    requires = {
        "hlchunk",
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
            notify = true,
            chars = {
                left_arrow = "━",
                horizontal_line = "━",
                vertical_line = "┃",
                -- vertical_line = "│",
                left_top = "┏",
                left_bottom = "┗",
                right_arrow = "━",
            },
            style = {
                { fg = cb },
                { fg = "#f35336" },
            },
            textobject = "ic",
            duration = 0,
            delay = 0,
        },

        indent = {
            enable = true,
            -- use_treesitter = false,
            notify = true,
            chars = {
                -- " ",
                -- "│",
                -- "¦",
                "┆",
                -- "┊",
            },
            delay = 50,
            filter_list = {
                function(v)
                    return v.level ~= 1
                end,
            },
        },

        line_num = {
            enable = false,
        },

        blank = {
            enable = false,
            chars = {
                " ",
                "․",
                -- "⁚",
                -- "⁖",
                -- "⁘",
                -- "⁙",
            },
            -- style = {
            --     -- "#806d9c",
            --
            --     { bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("cursorline")), "bg", "gui") },
            --     { bg = "", fg = "" },
            -- },
            style = {
                { bg = "#434437" },
                { bg = "#2f4440" },
                { bg = "#433054" },
                { bg = "#284251" },
            },
        },
    })
end

function M.after() end

return M
