local M = {
    requires = {
        "icon-picker",
    },
    keys = {
        {
            "<leader>ip",
            "<cmd>IconPickerNormal<cr>",
            desc = "pick icon in normal mode",
        },
    },
}

function M.load()
    M.icon_picker.setup({
        disable_legacy_commands = true,
    })
end

return M
