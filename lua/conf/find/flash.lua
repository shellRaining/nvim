local M = {
    requires = {
        "flash",
    },
}

-- stylua: ignore
M.keys = {
    { "s", mode = { "n", "x", "o" }, function() M.flash.jump() end, desc = "Flash" },
}

function M.load()
    M.flash.setup()
end

return M
