local M = {
    requires = {
        "carbon-now",
    },
}

local cmd = function()
    local sysname = vim.loop.os_uname().sysname

    if sysname == "Darwin" then
        return "open"
    elseif sysname == "Linux" then
        return "xdg-open"
    end
end

function M.load()
    M.carbon_now.setup({
        open_cmd = cmd(),
    })
end

return M
