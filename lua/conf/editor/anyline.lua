local M = {
    requires = {
        "anyline",
    },
}

function M.load()
    M.anyline.setup()
end

return M
