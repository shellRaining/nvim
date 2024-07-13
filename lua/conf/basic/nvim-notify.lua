-- https://github.com/rcarriga/nvim-notify

local public = require("utils.public")
local icons = public.get_icons_group("diagnostic", true)

local M = {
    requires = { "notify" },
}

function M.load()
    M.notify.setup({
        timeout = 3000,
        icons = {
            ERROR = icons.Error,
            WARN = icons.Warn,
            INFO = icons.Hint,
        },
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.75)
        end,
        background_colour = "#232B2E",
    })
end

return M
