-- https://github.com/folke/todo-comments.nvim

local api = require("utils.api")
local public = require("utils.public")
local icons = public.get_icons_group("tag_level", true)

local M = {
    requires = {
        "todo-comments",
    },
}

function M.before() end

function M.load()
    M.todo_comments.setup({
        keywords = {
            FIX = { icon = icons.FIX, color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
            TODO = { icon = icons.TODO, color = "info" },
            HACK = { icon = icons.HACK, color = "warning" },
            WARN = { icon = icons.WARN, color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = icons.PERF, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = icons.NOTE, color = "hint", alt = { "INFO" } },
            TEST = { icon = icons.TEST, color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        gui_style = {
            fg = "NONE",
            bg = "NONE",
            gui = "NONE",
        },
    })
end

function M.after()
    M.register_key()
end

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
