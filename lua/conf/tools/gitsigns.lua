local map = require("utils.map")

local M = {
    requires = {
        "gitsigns",
    },
    event = { "BufReadPre", "BufNewFile" },
}

function M.before() end

function M.load()
    M.gitsigns.setup({})
end

function M.after()
    M.register_key()
end

function M.register_key()
    map.bulk_register({
        {
            mode = { "n" },
            lhs = "<leader>gl",
            rhs = "<cmd>Gitsigns toggle_current_line_blame<cr>",
            options = { silent = true },
            description = "Toggle current line blame",
        },
        {
            mode = { "n" },
            lhs = "<leader>gD",
            rhs = M.gitsigns.diffthis,
            options = { silent = true },
            description = "Open deff view",
        },
        {
            mode = { "n" },
            lhs = "<leader>gd",
            rhs = M.gitsigns.toggle_deleted,
            options = { silent = true },
            description = "Show deleted lines",
        },
        {
            mode = { "n", "v" },
            lhs = "<leader>gr",
            rhs = M.gitsigns.reset_hunk,
            options = { silent = true },
            description = "Reset current hunk",
        },
        {
            mode = { "n" },
            lhs = "<leader>gR",
            rhs = M.gitsigns.reset_buffer,
            options = { silent = true },
            description = "Reset current buffer",
        },
        {
            mode = { "n" },
            lhs = "<leader>gp",
            rhs = M.gitsigns.preview_hunk,
            options = { silent = true },
            description = "Preview current hunk",
        },
        {
            mode = { "n" },
            lhs = "<leader>gs",
            rhs = M.gitsigns.stage_hunk,
            options = { silent = true },
            description = "Stage current hunk",
        },
        {
            mode = { "n" },
            lhs = "<leader>gS",
            rhs = M.gitsigns.stage_buffer,
            options = { silent = true },
            description = "Stage current buffer",
        },
        {
            mode = { "n" },
            lhs = "[h",
            rhs = M.gitsigns.prev_hunk,
            options = { silent = true, expr = true },
            description = "Jump to the prev hunk",
        },
        {
            mode = { "n" },
            lhs = "]h",
            rhs = M.gitsigns.next_hunk,
            options = { silent = true, expr = true },
            description = "Jump to the prev hunk",
        },
    })
end

return M
