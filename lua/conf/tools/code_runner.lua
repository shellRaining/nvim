local M = {
    requires = {
        "code_runner",
    },
    event = { "VeryLazy" },
    keys = {
        {
            "<leader>tc",
            function()
                local current_buffer = vim.api.nvim_get_current_buf()
                local windows = vim.api.nvim_list_wins()
                for _, win in ipairs(windows) do
                    vim.api.nvim_set_current_win(win)
                    local buffer_type = vim.api.nvim_buf_get_option(0, "buftype")
                    if buffer_type == "terminal" then
                        vim.cmd("close")
                    end
                end
                ---@diagnostic disable-next-line: param-type-mismatch
                vim.api.nvim_set_current_win(vim.fn.win_getid(current_buffer))
            end,
            desc = "Close all terminal",
        },
        {
            "<leader>rf",
            "<cmd>RunFile<CR>",
            desc = "Run the current project of file",
        },
        {
            "<leader>rc",
            "<cmd>RunCode<CR>",
            desc = "Run the current project of file",
        },
        {
            "<leader>rp",
            "<cmd>RunProject<CR>",
            desc = "Run the project",
        },
    },
}

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

return M
