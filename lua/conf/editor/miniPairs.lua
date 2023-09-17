local M = {
    requires = { "mini.pairs" },
    event = "VeryLazy",
}

function M.load()
    M.mini_pairs.setup({})
end

return M
