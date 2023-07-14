local api = require("utils.api.map")

local sysname = vim.loop.os_uname().sysname

if sysname == "Darwin" then
    api.register({
        mode = { "i" },
        lhs = "jk",
        rhs = "<esc>",
        options = { silent = true },
        description = "Escape Neovim insert mode",
    })
end
