-- https://github.com/rcarriga/nvim-notify

local api = require("utils.api")
local public = require("utils.public")
local options = require("core.options")
local icons = public.get_icons_group("diagnostic", true)

local M = {
    requires = {
        "notify",
    },
}

function M.before()
    M.register_key()
end

function M.load()
    M.notify.setup({
        stages = "fade",
        timeout = 3000,
        fps = 120,
        icons = {
            ERROR = icons.Error,
            WARN = icons.Warn,
            INFO = icons.Hint,
        },
        background_colour = options.transparent and "#000000" or "Normal",
    })
end

function M.after()
    vim.notify = setmetatable({}, {
        ---@diagnostic disable-next-line: unused-local
        __call = function(self, message, ...)
            return M.notify(message, ...)
        end,
        __index = M.notify,
    })
end

function M.register_key()
    api.map.bulk_register({
        {
            mode = { "n" },
            lhs = "<leader>fn",
            rhs = ":Notifications<cr>",
            options = { silent = true },
            description = "Find notices history",
        },
    })
end

return M
