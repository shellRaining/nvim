-- https://github.com/phaazon/hop.nvim

local api = require("utils.api")

local M = {
    requires = {
        "hop",
        "hop.hint",
    },
}

function M.before()
    M.register_key()
end

function M.load()
    M.hop.setup({
        { keys = "qwertyuiopasdfghjklzxcvbnm" },
    })
end

function M.after() end

function M.register_key()
    api.map.bulk_register({
        {
            mode = { "n", "v" },
            lhs = "ss",
            rhs = "<cmd>HopWord<cr>",
            options = { silent = true },
            description = "Jump to word head",
        },
        {
            mode = { "n", "v" },
            lhs = "sl",
            rhs = "<cmd>HopLine<cr>",
            options = { silent = true },
            description = "Jump to line",
        },
        {
            mode = { "n", "x" },
            lhs = "f",
            rhs = function()
                M.hop.hint_char1({ direction = M.hop_hint.HintDirection.AFTER_CURSOR, current_line_only = true })
            end,
            options = { remap = true },
        },
        {
            mode = { "n", "x" },
            lhs = "F",
            rhs = function()
                M.hop.hint_char1({ direction = M.hop_hint.HintDirection.BEFORE_CURSOR, current_line_only = true })
            end,
            options = { remap = true },
        },
        {
            mode = { "x" },
            lhs = "t",
            rhs = function()
                M.hop.hint_char1({ direction = M.hop_hint.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
            end,
            options = { remap = true },
        },
        {
            mode = { "x" },
            lhs = "T",
            rhs = function()
                M.hop.hint_char1({ direction = M.hop_hint.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
            end,
            options = { remap = true },
        },
    })
end

return M
