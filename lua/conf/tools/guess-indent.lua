local M = {
    requires = {
        "guess-indent",
    },
}

function M.load()
    M.guess_indent.setup()
end

return M
