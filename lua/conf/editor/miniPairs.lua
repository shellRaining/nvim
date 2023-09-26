local M = {
    requires = { "mini.pairs" },
    event = "InsertEnter",
}

function M.load()
    M.mini_pairs.setup({})
end

return M
