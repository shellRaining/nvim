local options = require("core.options")

local M = {
    requires = {
        "huez",
    },
}

function M.load()
    M.huez.setup({
        path = options.storage_directory .. "/huez",
    })
end

return M
