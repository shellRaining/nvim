-- https://github.com/numToStr/Comment.nvim
-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring

local M = {
    requires = {
        "Comment",
    },
}

function M.before() end

function M.load()
    M.comment.setup({})
end

function M.after() end

return M
