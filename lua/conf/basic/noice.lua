-- https://github.com/rcarriga/nvim-notify

local M = {
    requires = { "noice" },
    event = "VeryLazy",
}

function M.load()
    M.noice.setup({
        routes = {
            {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "%d+L, %d+B" },
                        { find = "; after #%d+" },
                        { find = "; before #%d+" },
                        { find = "%d fewer lines" },
                        { find = "%d more lines" },
                    },
                },
                opts = { skip = true },
            },
        },
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            progress = {
                enabled = true,
                format = "lsp_progress",
                format_done = "lsp_progress_done",
                throttle = 1000 / 30, -- frequency to update lsp progress message
                view = "mini",
            },
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        popupmenu = {
            backend = "cmp", -- backend to use to show regular cmdline completions
            kind_icons = {}, -- set to `false` to disable icons
        },
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true, -- add a border to hover docs and signature help
            command_palette = {
                views = {
                    cmdline_popup = {
                        position = {
                            row = "50%",
                            col = "50%",
                        },
                        size = {
                            min_width = 60,
                            width = "auto",
                            height = "auto",
                        },
                    },
                },
            },
        },
        views = {
            mini = {
                win_options = {
                    winblend = 0,
                },
            },
        },
        messages = {
            enabled = true, -- enables the Noice messages UI
            view = "mini", -- default view for messages
            view_error = "notify", -- view for errors
            view_warn = "notify", -- view for warnings
            view_history = "notify", -- view for :messages
            view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
        },
        format = {
            spinner = {
                -- name = "arc",
                -- name = "arrow",
                name = "dots",
                -- name = 'mindblown',
                -- name = 'moon',
                -- name = "soccerHeader",
                -- name = 'weather',
            },
        },
    })
end

-- stylua: ignore
M.keys = {
    { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message", },
    { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History", },
    { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All", },
    { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All", },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = { "i", "n", "s" }, },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = { "i", "n", "s" }, },
}

return M
