local map = require("utils.map")

local sysname = vim.loop.os_uname().sysname

if sysname == "Darwin" then
    map.register({
        mode = { "i", "s" },
        lhs = "jk",
        -- rhs = function()
        --     vim.cmd("nohlsearch")
        --     vim.cmd("stopinsert")
        -- end,
        -- NOTE: use this is because when in select mode, we can't escape
        rhs = "<cmd>noh<cr><esc>",
        options = { silent = true },
        description = "Clear search highlight",
    })
end
