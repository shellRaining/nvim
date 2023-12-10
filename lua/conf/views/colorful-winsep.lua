local M = {
    requires = {
        "colorful-winsep",
    },
}

function M.load()
    M.colorful_winsep.setup({
        -- timer refresh rate
        interval = 30,
        -- This plugin will not be activated for filetype in the following table.
        no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
        -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
        symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
        close_event = function()
            -- Executed after closing the window separator
        end,
        create_event = function()
            -- Executed after creating the window separator
        end,
    })
end

function M.after()
    vim.api.nvim_create_user_command("NvimSeparatorDel", function()
        M.colorful_winsep.NvimSeparatorDel()
    end, { desc = "Delete the window separator" })
end

return M
