local M = { requires = { "flatten" } }

function M.load()
    M.flatten.setup({
        window = { open = "alternate" },
    })
end

return M
