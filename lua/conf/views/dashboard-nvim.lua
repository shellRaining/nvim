local M = {
    requires = { "dashboard" },
    event = "VimEnter",
}

function M.load()
    M.dashboard.setup({
        theme = "doom", --  theme is doom and hyper default is hyper
        config = {
            header = {
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
                " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
                " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
                " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
                " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
                " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
                "",
                "",
                "",
            },
            center = {
                {
                    icon = " ",
                    icon_hl = "Label",
                    desc = "Projects",
                    desc_hl = "Label",
                    action = "Telescope projects theme=dropdown",
                    key = "p",
                    key_hl = "Label",
                },
                {
                    icon = " ",
                    icon_hl = "Label",
                    desc = "Grep",
                    desc_hl = "Label",
                    action = "Telescope live_grep theme=dropdown",
                    key = "g",
                    key_hl = "Label",
                },
                {
                    icon = " ",
                    icon_hl = "Label",
                    desc = "Files",
                    desc_hl = "Label",
                    action = require("utils.telescope").telescope("files", { theme = "dropdown" }),
                    key = "f",
                    key_hl = "Label",
                },
                {
                    icon = " ",
                    icon_hl = "Label",
                    desc = "Recent Files",
                    desc_hl = "Label",
                    action = "Telescope oldfiles theme=dropdown",
                    key = "o",
                    key_hl = "Label",
                },
                {
                    icon = " ",
                    icon_hl = "Label",
                    desc = "Config Files",
                    desc_hl = "Label",
                    action = "Telescope find_files cwd=~/.config/nvim theme=dropdown",
                    key = "c",
                    key_hl = "Label",
                },
                {
                    icon = "󰒲 ",
                    icon_hl = "Label",
                    desc = "Lazy",
                    desc_hl = "Label",
                    action = "Lazy",
                    key = "l",
                    key_hl = "Label",
                },
                {
                    icon = " ",
                    icon_hl = "Number",
                    desc = "quit",
                    desc_hl = "Number",
                    action = "quit",
                    key = "q",
                    key_hl = "Number",
                },
            },
            -- project = { limit = 8, icon = "", label = "recent projects", action = "Telescope find_files cwd=" },
            packages = { enable = false },
            footer = {
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "designed by askfiy & shellRaining ~~~",
            },
        }, --  config used for theme
    })
end

return M
