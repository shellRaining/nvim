local M = {
    requires = { "ts-comments" },
}

function M.load()
    M.ts_comments.setup({})
end

return M
