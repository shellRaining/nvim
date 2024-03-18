local map = require("utils.map")
local public = require("utils.public")
local icons = public.get_icons_group("diagnostic", true)

local M = {
    requires = {
        "nvim-tree",
    },
}

function M.before()
    M.register_key()
end

function M.load()
    M.nvim_tree.setup({
        disable_netrw = true,
        hijack_netrw = false,
        hijack_cursor = true,
        update_cwd = true,
        reload_on_bufenter = true,
        notify = {
            threshold = vim.log.levels.WARN,
        },
        update_focused_file = {
            enable = true,
            update_cwd = false,
        },
        view = {
            side = "left",
            width = 30,
            signcolumn = "yes",
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            icons = {
                hint = icons.Hint,
                info = icons.Info,
                warning = icons.Warn,
                error = icons.Error,
            },
        },
        actions = {
            use_system_clipboard = true,
            change_dir = {
                enable = true,
                global = true,
                restrict_above_cwd = false,
            },
            open_file = {
                resize_window = true,
                window_picker = {
                    enable = true,
                },
            },
        },
        trash = {
            cmd = "trash",
            require_confirm = true,
        },
        filters = {
            dotfiles = false,
            custom = { "node_modules", "\\.cache", "__pycache__" },
            exclude = {},
        },
        renderer = {
            add_trailing = true,
            root_folder_label = true,
            highlight_git = true,
            highlight_opened_files = "none",
            indent_width = 2,
            indent_markers = {
                enable = true,
                inline_arrows = true,
                icons = {
                    corner = "└",
                    edge = "│",
                    item = "│",
                    bottom = "─",
                    none = " ",
                },
            },
            icons = {
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = false,
                    git = false,
                },
            },
        },
    })
end

function M.after() end

function M.register_key()
    local tree_api = require("nvim-tree.api")
    map.bulk_register({
        {
            mode = { "n" },
            lhs = "<leader>u1",
            rhs = function()
                local aerial_info = public.get_aerial_info()
                public.toggle_sidebar("NvimTree")
                require("nvim-tree.api").tree.toggle({ find_file = true, focus = true })
                public.reset_aerial_width(aerial_info)
            end,
            options = { silent = true },
            description = "Open File Explorer",
        },
        {
            mode = { "n" },
            lhs = "?",
            rhs = function()
                tree_api.tree.toggle_help()
            end,
            options = { silent = true },
            description = "Toggle help",
        },
    })
end

return M
