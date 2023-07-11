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

local ignore_message = {
    -- LSP
    "%[LSP%]%[.+%] timeout",
    "LSP%[id=%d*%] client has shut down after sending Log",
    "LSP%[id=%d*%] client has shut down during progress update",
    "LSP%[id=%d*%] client has shut down while creating progress report",
    "LSP%[%d*%] client has shut down after sending a workspace/configuration request",
    "method textDocument/signatureHelp is not supported by any of the servers registered for the current buffer",
    "method textDocument/documentSymbol is not supported by any of the servers registered for the current buffer",
    "warning: multiple different client offset_encodings detected for buffer, this is not supported yet",
    'Server "emmet_ls" does not support documentSymbols.',
    "No information available",
    "Failed to attach to volar for current buffer. Already attached to volar",
}

function M.before()
    M.register_key()
end

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

function M.after()
    vim.notify = setmetatable({}, {
        ---@diagnostic disable-next-line: unused-local
        __call = function(self, message, ...)
            for _, v in ipairs(ignore_message) do
                if message:match(v) then
                    return
                end
            end
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
