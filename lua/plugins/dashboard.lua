local dashboard = require("core.config").dashboard

local dashboard_config = {
  "glepnir/dashboard-nvim",
  cond = dashboard == "dashboard",
  event = "VimEnter",
  opts = {
    theme = "doom",
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
        "███████╗██╗  ██╗███████╗██╗     ██╗     ██████╗  █████╗ ██╗███╗   ██╗██╗███╗   ██╗ ██████╗ ",
        "██╔════╝██║  ██║██╔════╝██║     ██║     ██╔══██╗██╔══██╗██║████╗  ██║██║████╗  ██║██╔════╝ ",
        "███████╗███████║█████╗  ██║     ██║     ██████╔╝███████║██║██╔██╗ ██║██║██╔██╗ ██║██║  ███╗",
        "╚════██║██╔══██║██╔══╝  ██║     ██║     ██╔══██╗██╔══██║██║██║╚██╗██║██║██║╚██╗██║██║   ██║",
        "███████║██║  ██║███████╗███████╗███████╗██║  ██║██║  ██║██║██║ ╚████║██║██║ ╚████║╚██████╔╝",
        "╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝ ╚═════╝  ",
        "",
        "",
        "",
      },
      center = {
        {
          icon = " ",
          icon_hl = "Label",
          desc = "Files",
          desc_hl = "Label",
          -- action = require("utils.telescope").telescope("files", { theme = "dropdown" }),
          action = "FzfLua files",
          key = "f",
          key_hl = "Label",
        },
        {
          icon = " ",
          icon_hl = "Label",
          desc = "Grep",
          desc_hl = "Label",
          -- action = "Telescope live_grep theme=dropdown",
          action = "FzfLua live_grep",
          key = "/",
          key_hl = "Label",
        },
        {
          icon = " ",
          icon_hl = "Label",
          desc = "Recent",
          desc_hl = "Label",
          -- action = "Telescope oldfiles theme=dropdown",
          action = "FzfLua oldfiles",
          key = "o",
          key_hl = "Label",
        },
        {
          icon = " ",
          icon_hl = "Label",
          desc = "Session",
          desc_hl = "Label",
          action = "SelectSession",
          key = "r",
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
        "designed by shellRaining ~~~",
      },
    },
  },
}

return {
  dashboard_config,
}
