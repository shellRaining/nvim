local map = require("utils.map")

local M = {
    requires = {
        "moveline",
    },
    event = { "BufReadPre", "BufNewFile" },
}

function M.before() end

function M.load() end

function M.after()
    M.register_key()
end

function M.register_key()
    map.bulk_register({
        {
            mode = { "n" },
            lhs = "<M-k>",
            rhs = M.moveline.up,
            options = { silent = true },
            description = "move line up",
        },
        {
            mode = { "n" },
            lhs = "<M-j>",
            rhs = M.moveline.down,
            options = { silent = true },
            description = "move line down",
        },
        {
            mode = { "v" },
            lhs = "<M-k>",
            rhs = M.moveline.block_up,
            options = { silent = true },
            description = "move block up",
        },
        {
            mode = { "v" },
            lhs = "<M-j>",
            rhs = M.moveline.block_down,
            options = { silent = true },
            description = "move block down",
        },
    })
end

return M
