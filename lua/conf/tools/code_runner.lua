local api = require("utils.api")

local M = {
    requires = {
        "code_runner",
    },
}

function M.before() end

function M.load()
    M.code_runner.setup({
        filetype = {
            typescript = "deno run",
        },
        focus = false,
        -- project = {
        --     ["~/Documents/learnsth/rust/guessing_name"] = {
        --         name = "guessing_name",
        --         description = "guessing_name",
        --         command = "cargo run",
        --     },
        -- },
    })
end

function M.after()
    M.register_key()
end

function M.register_key()
    local function close_all_terminals()
        -- 获取当前窗口的缓冲区ID
        local current_buffer = vim.api.nvim_get_current_buf()

        -- 遍历所有窗口
        local windows = vim.api.nvim_list_wins()
        for _, win in ipairs(windows) do
            vim.api.nvim_set_current_win(win)
            local buffer_type = vim.api.nvim_buf_get_option(0, "buftype")
            if buffer_type == "terminal" then
                vim.cmd("close")
            end
        end

        -- 切换回原来的窗口
        vim.api.nvim_set_current_win(vim.fn.win_getid(current_buffer))
    end

    vim.api.nvim_set_keymap("n", "<Leader>ct", "<Cmd>call close_all_terminals()<CR>", { noremap = true, silent = true })
    api.map.bulk_register({
        {
            mode = { "n" },
            lhs = "<leader>tc",
            rhs = close_all_terminals,
            options = { silent = true },
            description = "close all terminal",
        },
        {
            mode = { "n" },
            lhs = "<leader>rf",
            rhs = "<cmd>RunFile<CR>",
            options = { silent = true },
            description = "run the current project of file",
        },
        {
            mode = { "n" },
            lhs = "<leader>rc",
            rhs = "<cmd>RunCode<CR>",
            options = { silent = true },
            description = "run the current project of file",
        },
        {
            mode = { "n" },
            lhs = "<leader>rp",
            rhs = "<cmd>RunProject<CR>",
            options = { silent = true },
            description = "Find todo tag in the current workspace",
        },
    })
end

return M
