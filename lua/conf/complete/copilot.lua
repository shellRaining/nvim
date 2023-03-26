-- https://github.com/zbirenbaum/copilot-cmp

local M = {
    requires = {
        "copilot",
    },
}

function M.before() end

function M.load()
    M.copilot.setup({})
end

function M.after() end

return M
