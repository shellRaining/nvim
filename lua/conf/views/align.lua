-- https://github.com/shellRaining/hlchunk.nvim
local api = require("utils.api")

local M = {
    requires = {
        "align",
    },
}

function M.before() end

function M.load()
    api.map.register({
        mode = { "x" },
        lhs = "<leader>=",
        rhs = function()
            M.align.align_to_string(true, true, true)
        end,
        options = { silent = true },
        description = "align code",
    })
end

function M.after() end

return M
