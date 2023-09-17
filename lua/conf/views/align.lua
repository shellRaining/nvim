local map = require("utils.map")

local M = {
    requires = {
        "align",
    },
}

function M.before() end

function M.load()
    map.register({
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
