-- https://github.com/shellRaining/hlchunk.nvim

local M = {
    requires = {
        "hlchunk",
        "hlchunk.mods.chunk",
        "hlchunk.mods.indent",
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
    M.hlchunk_mods_chunk({
        notify = true,
        chars = {
            left_arrow = "━",
            horizontal_line = "━",
            vertical_line = "┃",
            left_top = "┏",
            left_bottom = "┗",
            right_arrow = "━",
        },
        textobject = "ic",
        max_file_size = 10 * 1024 * 1024,
        -- duration = 300,
        delay = 300,
    }):enable()
    M.hlchunk_mods_indent({
        notify = true,
        chars = {
            -- " ",
            -- "│",
            -- "¦",
            "┆",
            -- "┊",
        },
    }):enable()
    M.hlchunk.setup({
        -- chunk = {
        --     enable = true,
        --     use_treesitter = true,
        --     notify = true,
        --     chars = {
        --         horizontal_line = "━",
        --         vertical_line = "┃",
        --         left_top = "┏",
        --         left_bottom = "┗",
        --         right_arrow = "━",
        --     },
        --     style = {
        --         { fg = cb },
        --         { fg = "#f35336" },
        --     },
        --     textobject = "ic",
        -- },
        --
        -- indent = {
        --     enable = true,
        --     -- use_treesitter = false,
        --     notify = true,
        --     chars = {
        --         -- " ",
        --         -- "│",
        --         -- "¦",
        --         "┆",
        --         -- "┊",
        --     },
        -- },
        --
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
        -- context = {
        --     enable = false,
        -- },
    })
end

function M.after() end

return M
