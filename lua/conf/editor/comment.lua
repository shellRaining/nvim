-- https://github.com/numToStr/Comment.nvim
-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring

local M = {
    requires = { "Comment" },
}

function M.load()
    M.comment.setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
end

return M
