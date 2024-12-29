local dashboard = require("core.config").dashboard

local function loadLastSession()
  local session = require("persistence").load({ last = true })
  if session then
    require("persistence").load({ last = true })
  else
    print("No last session found")
  end
end

vim.api.nvim_create_user_command("LoadLastSession", function()
  loadLastSession()
end, {})

local dashboardConfig = {
  "glepnir/dashboard-nvim",
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
          key = "g",
          key_hl = "Label",
        },
        {
          icon = " ",
          icon_hl = "Label",
          desc = "Recent Files",
          desc_hl = "Label",
          -- action = "Telescope oldfiles theme=dropdown",
          action = "FzfLua oldfiles",
          key = "o",
          key_hl = "Label",
        },
        {
          icon = " ",
          icon_hl = "Label",
          desc = "Recent session",
          desc_hl = "Label",
          action = "LoadLastSession",
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

local dashboard2Config = {
  dashboard = dashboardConfig,
}

return {
  dashboard2Config[dashboard],
}
