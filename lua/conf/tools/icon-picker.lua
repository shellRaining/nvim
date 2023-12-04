local map = require("utils.map")

local M = {
    requires = {
        "icon-picker",
    },
}

function M.load()
    M.icon_picker.setup({
        disable_legacy_commands = true,
    })
end

function M.after()
    M.register_key()
end

function M.register_key()
    map.bulk_register({
        {
            mode = { "n" },
            lhs = "<leader>ce",
            rhs = "<cmd>IconPickerNormal<cr>",
            options = { silent = true },
            description = "pick icon in normal mode",
        },
    })
end

return M
