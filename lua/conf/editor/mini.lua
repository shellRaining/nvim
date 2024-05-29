local M = {
    requires = { "mini.indentscope" },
}

function M.load()
    M.mini_indentscope.setup({})
end

return M
