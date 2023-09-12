-- https://github.com/folke/flash.nvim

local api = require("utils.api")

local M = {
    requires = {
        "flash",
    },
}

function M.before()
    M.register_key()
end

function M.load()
    M.flash.setup({})
end

function M.after() end

function M.register_key()
    api.map.bulk_register({
        {
            mode = { "n", "o", "x" },
            lhs = "s",
            rhs = function()
                M.flash.jump()
            end,
            options = { silent = true },
            description = "Flash",
        },
        {
            mode = { "n", "o", "x" },
            lhs = "S",
            rhs = function()
                M.flash.treesitter()
            end,
            options = { silent = true },
            description = "Flash treesitter",
        },
        {
            mode = { "o" },
            lhs = "r",
            rhs = function()
                M.flash.remote()
            end,
            options = { silent = true },
            description = "Remote Flash",
        },
        {
            mode = { "o", "x" },
            lhs = "R",
            rhs = function()
                M.flash.treesitter_search()
            end,
            options = { silent = true },
            description = "Treesitter Search",
        },
        {
            mode = { "c" },
            lhs = "<c-s>",
            rhs = function()
                M.flash.toggle()
            end,
            options = { silent = true },
            description = "Toggle Flash Search",
        },
    })
end

return M
