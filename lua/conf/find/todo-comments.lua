-- https://github.com/folke/todo-comments.nvim

local api = require("utils.api")

local M = {
    requires = {
        "todo-comments",
    },
}

function M.before()
    M.register_key()
end

function M.load()
    M.todo_comments.setup({
        keywords = {
            -- alt = alias
            NOTE = { color = "#D9D9D9" },
            TODO = { color = "#D9D9D9" },
            PERF = { color = "#CCA700" },
            WARN = { color = "#CCA700" },
            ERROR = { color = "#F14C4C" },
            HACK = {
                color = "#DDB6F2",
                alt = { "DEP" },
            },
            FIX = {
                color = "#DDB6F2",
                alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
            },
        },
        gui_style = {
            fg = "NONE",
            bg = "NONE",
            gui = "NONE",
        },
    })
end

function M.after() end

function M.register_key()
    api.map.bulk_register({
        {
            mode = { "n" },
            lhs = "<leader>fd",
            rhs = function()
                require("telescope").extensions["todo-comments"].todo()
            end,
            options = { silent = true },
            description = "Find todo tag in the current workspace",
        },
        {
            mode = { "n" },
            lhs = "<leader>qd",
            rhs = "<cmd>TodoLocList<CR>",
            options = { silent = true },
            description = "Find todo tag in the current workspace",
        },
    })
end

return M
