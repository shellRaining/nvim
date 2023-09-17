local public = require("utils.public")
local icons = public.get_icons_group("tag_level", true)

local M = {
    requires = { "todo-comments" },
    keys = {
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
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
    })
end

return M
