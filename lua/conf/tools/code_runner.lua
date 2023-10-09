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

local spark_path = "~/Documents/learnsth/spark-3.5.0-bin-hadoop3"
function M.load()
    M.code_runner.setup({
        filetype = {
            typescript = "deno run",
            python = "python3",
        },
        focus = false,
        project = {
            ["~/Documents/learnsth/rust/guessing_name"] = {
                name = "guessing_name",
                description = "guessing_name",
                command = "cargo run",
            },
            -- ["~/Documents/learnsth/spark-3.5.0-bin-hadoop3"] = {
            --     name = "lab1",
            --     description = "calculate Discrete Frechet Distance",
            --     command = spark_path .. "/bin/spark-submit " .. spark_path .. "/test.py",
            -- },
        },
    })
end

return M
