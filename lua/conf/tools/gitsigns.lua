-- https://github.com/lewis6991/gitsigns.nvim

local api = require("utils.api")

local M = {
    requires = {
        "gitsigns",
    },
}

function M.before() end

function M.load()
    M.gitsigns.setup({})
end

function M.after() end

function M.register_key()
    api.map.bulk_register({
        {
            mode = { "n" },
            lhs = "<leader>gl",
            rhs = "<cmd>Gitsigns toggle_current_line_blame<cr>",
            options = { silent = true },
            description = "Toggle current line blame",
        },
        {
            mode = { "n" },
            lhs = "<leader>gh",
            rhs = "<cmd>lua require'gitsigns'.preview_hunk()<cr>",
            options = { silent = true },
            description = "Preview current hunk",
        },
        {
            mode = { "n" },
            lhs = "<leader>gH",
            rhs = "<cmd>lua require'gitsigns'.blame_line{full=true}<cr>",
            options = { silent = true },
            description = "Show current block blame",
        },
        {
            mode = { "n" },
            lhs = "<leader>gd",
            rhs = "<cmd>Gitsigns diffthis<cr>",
            options = { silent = true },
            description = "Open deff view",
        },
        {
            mode = { "n" },
            lhs = "<leader>gD",
            rhs = "<cmd>Gitsigns toggle_deleted<cr>",
            options = { silent = true },
            description = "Show deleted lines",
        },
        {
            mode = { "n", "v" },
            lhs = "<leader>gr",
            rhs = "<cmd>Gitsigns reset_hunk<cr>",
            options = { silent = true },
            description = "Reset current hunk",
        },
        {
            mode = { "n" },
            lhs = "<leader>gR",
            rhs = "<cmd>Gitsigns reset_buffer<cr>",
            options = { silent = true },
            description = "Reset current buffer",
        },
        {
            mode = { "n" },
            lhs = "[c",
            rhs = function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    M.gitsigns.prev_hunk()
                end)
                return "<Ignore>"
            end,
            options = { silent = true, expr = true },
            description = "Jump to the prev hunk",
        },
        {
            mode = { "n" },
            lhs = "]c",
            rhs = function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    M.gitsigns.next_hunk()
                end)
                return "<Ignore>"
            end,
            options = { silent = true, expr = true },
            description = "Jump to the next hunk",
        },
    })
end

return M
