-- https://github.com/numToStr/Comment.nvim
-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring

local M = {
    requires = { "Comment" },

}

function M.load()
    M.comment.setup()
end

return M
