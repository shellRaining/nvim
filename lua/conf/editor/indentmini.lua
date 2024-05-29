local M = {
    requires = { "indentmini" },
}

function M.load()
    M.indentmini.setup({})
end

return M
