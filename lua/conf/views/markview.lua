local M = {
    requires = {
        "markview",
    },
    ft = "markdown",
}

function M.load()
    M.markview.setup()
end

return M
