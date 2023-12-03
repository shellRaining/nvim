local map = require("utils.map")

local M = {
    requires = {
        "translate",
    },
}

function M.before()
    M.register_key()
end

function M.load()
    M.translate.setup({
        default = {
            command = "translate_shell",
        },
        preset = {
            output = {
                split = {
                    append = true,
                },
            },
        },
    })
end

function M.register_key()
    map.bulk_register({
        {
            mode = { "v" },
            lhs = "<c-t>",
            rhs = "<cmd>Translate ZH -source=EN<cr><esc>",
            options = { silent = true },
            description = "Translate selection",
        },
        {
            mode = { "n" },
            lhs = "<leader>tw",
            rhs = "viw<cmd>Translate ZH<cr><esc>",
            options = { silent = true },
            description = "Translate word",
        }
    })
end

return M
