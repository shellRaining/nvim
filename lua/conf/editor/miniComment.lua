local M = {
    requires = { "mini.comment" },
    event = "VeryLazy",
}

function M.load()
    M.mini_comment.setup({})
end

return M
