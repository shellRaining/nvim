-- local map = require("utils.map")

local M = {
    requires = {
        "harpoon",
        "harpoon.ui",
    },
}

function M.before()
    -- M.register_key()
end

function M.load()
    M.harpoon.setup({
        settings = {
            save_on_toggle = true,
        },
    })
    -- M.harpoon:setup()

    vim.keymap.set("n", "<leader>ha", function()
        M.harpoon:list():append()
    end)
    vim.keymap.set("n", "<leader>hh", function()
        M.harpoon_ui:toggle_quick_menu(M.harpoon:list())
    end)

    vim.keymap.set("n", "<leader>hi", function()
        M.harpoon:list():select(1)
    end)
    vim.keymap.set("n", "<leader>hj", function()
        M.harpoon:list():select(2)
    end)
    vim.keymap.set("n", "<leader>hk", function()
        M.harpoon:list():select(3)
    end)
    vim.keymap.set("n", "<leader>hl", function()
        M.harpoon:list():select(4)
    end)
end

function M.after() end

return M
