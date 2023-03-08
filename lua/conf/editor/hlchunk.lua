-- https://github.com/numToStr/Comment.nvim
-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring

local M = {
    requires = {
        "hlchunk"
    },
}

function M.before() end

function M.load()
    M.hlchunk.setup({
    })
end

function M.after() end

return M
