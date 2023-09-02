local api = require("utils.api.map")

local sysname = vim.loop.os_uname().sysname

if sysname == "Darwin" then
    api.register({
        mode = { "i" },
        lhs = "jk",
        rhs = function()
            vim.cmd("nohlsearch")
            vim.cmd("stopinsert")
        end,
        options = { silent = true },
        description = "Clear search highlight",
    })
end
