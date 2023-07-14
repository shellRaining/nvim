-- https://github.com/rcarriga/nvim-notify

local public = require("utils.public")
local options = require("core.options")
local icons = public.get_icons_group("diagnostic", true)

local M = {
    requires = {
        "notify",
    },
}

function M.load()
    M.notify.setup({
        stages = "fade",
        timeout = 3000,
        fps = 60,
        icons = {
            ERROR = icons.Error,
            WARN = icons.Warn,
            INFO = icons.Hint,
        },
        background_colour = options.transparent and "#000000" or "Normal",
    })
end

return M
