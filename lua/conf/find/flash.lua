local M = {
    requires = {
        "flash",
    },
    event = "VeryLazy",
}

function M.load()
    M.flash.setup({})
end

-- stylua: ignore
M.keys = {
    { "s", mode = { "n", "x", "o" }, function() M.flash.jump() end, desc = "Flash" },
    { "S", mode = { "n", "o", "x" }, function() M.flash.treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() M.flash.remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() M.flash.treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() M.flash.toggle() end, desc = "Toggle Flash Search" },
}

return M
