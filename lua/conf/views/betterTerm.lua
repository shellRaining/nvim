local api = require("utils.api")

local M = {
    requires = {
        "betterTerm",
    },
}

function M.before() end

function M.load()
    M.betterterm.setup({})
end

function M.after()
    M.register_key()
end

function M.register_key()
    api.map.bulk_register({
        {
            mode = { "n", "t" },
            lhs = "<leader>to",
            rhs = function()
                M.betterterm.open()
            end,
            options = { silent = true },
            description = "open terminal",
        },
        {
            mode = { "n", "t" },
            lhs = "<leader>ts",
            rhs = function()
                M.betterterm.select()
            end,
            options = { silent = true },
            description = "select terminal",
        },
    })
end

return M
