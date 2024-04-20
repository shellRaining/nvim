local M = {
    requires = {
        "neoclip",
        "telescope",
    },
    keys = {
        { "<leader>fy", "<cmd>Telescope neoclip<cr>", desc = "Yank History" },
        { "<c-y>", "<cmd>Telescope neoclip<cr>", mode = "i", desc = "Yank History" },
    },
}

function M.load()
    M.telescope.load_extension("neoclip")
    M.neoclip.setup({
        history = 1000,
        enable_persistent_history = true,
        continuous_sync = true,
        db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
        filter = function(data)
            for _, line in ipairs(data.event.regcontents) do
                if vim.fn.match(line, [[^\s*$]]) ~= -1 then
                    return false
                end
            end
            return true
        end,
        keys = {
            telescope = {
                i = {
                    select = "<nop>",
                    paste = "<cr>",
                    paste_behind = "<nop>",
                    replay = "<nop>", -- replay a macro
                    delete = "<c-d>", -- delete an entry
                    edit = "<c-e>", -- edit an entry
                    custom = {},
                },
                n = {
                    select = "<nop>",
                    paste = "<cr>",
                    --- It is possible to map to more than one key.
                    -- paste = { 'p', '<c-p>' },
                    paste_behind = "<nop>",
                    replay = "<nop>",
                    delete = "dd",
                    edit = "e",
                    custom = {},
                },
            },
        },
    })
end

return M
