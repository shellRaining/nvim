local map = require("utils.map")

local M = {
    requires = {},
}

function M.load()
    local harpoon = require("harpoon")
    harpoon:setup()

    map.bulk_register({
        {
            mode = { "n" },
            lhs = "<leader>ha",
            rhs = function()
                harpoon:list():append()
            end,
            options = { silent = true },
            description = "append current file to harpoon",
        },
        {
            mode = { "n" },
            lhs = "<leader>hh",
            rhs = function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            options = { silent = true },
            description = "toggle harpoon menu",
        },
        {
            mode = { "n" },
            lhs = "<leader>1",
            rhs = function()
                harpoon:list():select(1)
            end,
            options = { silent = true },
            description = "select harpoon 1",
        },
        {
            mode = { "n" },
            lhs = "<leader>2",
            rhs = function()
                harpoon:list():select(2)
            end,
            options = { silent = true },
            description = "select harpoon 2",
        },
        {
            mode = { "n" },
            lhs = "<leader>3",
            rhs = function()
                harpoon:list():select(3)
            end,
            options = { silent = true },
            description = "select harpoon 3",
        },
        {
            mode = { "n" },
            lhs = "<leader>4",
            rhs = function()
                harpoon:list():select(4)
            end,
            options = { silent = true },
            description = "select harpoon 4",
        },
    })
end

return M
