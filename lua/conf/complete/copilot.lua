local map = require("utils.map")

local M = {
    requires = { "copilot" },
}

function M.before() end

function M.load()
    M.copilot.setup({
        panel = { enabled = false },
        suggestion = {
            enable = true,
            auto_trigger = true,
            keymap = false,
        },
        filetypes = {
            markdown = true,
        },
    })
end

function M.after()
    M.register_key()
end

function M.register_key()
    map.bulk_register({
        {
            mode = { "n" },
            lhs = "<leader>ce",
            rhs = function()
                vim.cmd("Copilot enable")
                vim.notify("Copilot enable", "info", { title = "Copilot" })
            end,
            options = { silent = true },
            description = "enable copilot",
        },
        {
            mode = { "n" },
            lhs = "<leader>cd",
            rhs = function()
                vim.cmd("Copilot disable")
                vim.notify("Copilot disabled", "info", { title = "Copilot" })
            end,
            options = { silent = true },
            description = "disable copilot",
        },
    })
end

return M
